import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:konekto/widgets/camera/camera_widget.dart';
import 'package:konekto/widgets/message/chat_message_widget.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class MessagesDetailPage extends StatelessWidget {
  const MessagesDetailPage(
      {super.key, required this.communityRoom, required this.communityName});
  final types.Room communityRoom;
  final String communityName;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MessagesDetail(
          communityRoom: communityRoom,
          communityName: communityName,
        ),
      );
}

class MessagesDetail extends StatefulWidget {
  const MessagesDetail({
    super.key,
    required this.communityRoom,
    required this.communityName,
  });
  final types.Room communityRoom;
  final String communityName;
  // required this.cameras,
  // final List<CameraDescription> cameras;

  @override
  State<MessagesDetail> createState() => _MessagesDetailState();
}

class _MessagesDetailState extends State<MessagesDetail> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  var textController = TextEditingController(text: '');
  String formattedDate = DateFormat('h:mm a').format(DateTime.now());
  bool _isAttachmentUploading = false;

  late List<Map> chatMessages = [
    {
      'type': ChatType.opposite,
      'message': "Hi Team, Besok pagi kita jadi main?",
      'time': '3:00 PM'
    },
    {
      'type': ChatType.personal,
      'message': "Jadi bang, langsung kumpul ditempat saja",
      'time': '3:00 PM'
    },
    {
      'type': ChatType.opposite,
      'message': "Okee, lengkap semua kita kan bang?",
      'time': '3:00 PM'
    },
    {
      'type': ChatType.opposite,
      'message': "Si Andy itu jadi ikut gak ya?",
      'time': '3:00 PM'
    },
  ];

  @override
  void initState() {
    super.initState();
    // _loadMessages();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.communityRoom.id);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.communityRoom.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.communityRoom.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.communityRoom.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance
        .updateMessage(updatedMessage, widget.communityRoom.id);
  }

  void _handleSendPressed(types.PartialText message) {
    // final textMessage = types.TextMessage(
    //   author: _user,
    //   createdAt: DateTime.now().millisecondsSinceEpoch,
    //   id: const Uuid().v4(),
    //   text: message.text,
    // );

    // _addMessage(textMessage);
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.communityRoom.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  // void _loadMessages() async {
  //   final response = await rootBundle.loadString('assets/messages.json');
  //   final messages = (jsonDecode(response) as List)
  //       .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
  //       .toList();

  //   setState(() {
  //     _messages = messages;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoPageScaffold(
  //       // Uncomment to change the background color
  //       // backgroundColor: CupertinoColors.systemPink,
  //       navigationBar: CupertinoNavigationBar(
  //         middle: Text(widget.communityName),
  //         leading: CupertinoNavigationBarBackButton(
  //           color: CupertinoColors.black,
  //           onPressed: () =>
  //               Navigator.of(context, rootNavigator: true).pop(context),
  //         ),
  //       ),
  //       child: SafeArea(
  //         // padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Expanded(
  //                 child: SizedBox(
  //               height: 200.0,
  //               child: ListView(
  //                   scrollDirection: Axis.vertical,
  //                   shrinkWrap: true,
  //                   children: [
  //                     for (var index = 0; index < chatMessages.length; index++)
  //                       ChatMessage(
  //                         textType: TextType.text,
  //                         type: chatMessages[index]['type'],
  //                         chatMessage: chatMessages[index]['message'],
  //                         chatTime: chatMessages[index]['time'],
  //                       ),
  //                     for (var index = 0; index < chatMessages.length; index++)
  //                       ChatMessage(
  //                         textType: TextType.text,
  //                         type: chatMessages[index]['type'],
  //                         chatMessage: chatMessages[index]['message'],
  //                         chatTime: chatMessages[index]['time'],
  //                       ),
  //                   ]),
  //             )),
  //             // const CameraApp(),
  //             Container(
  //               decoration: const BoxDecoration(
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: CupertinoColors.white,
  //                     spreadRadius: 5,
  //                     blurRadius: 7,
  //                     offset: Offset(0, 20), // changes position of shadow
  //                   ),
  //                 ],
  //               ),
  //               child: Padding(
  //                 padding:
  //                     const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     GestureDetector(
  //                       onTap: () => Navigator.of(context, rootNavigator: true)
  //                           .push(CupertinoPageRoute(
  //                               builder: (context) => CameraScreen(
  //                                     cameras: widget.cameras,
  //                                   ))),
  //                       child: const Icon(
  //                         CupertinoIcons.camera,
  //                         color: CupertinoColors.black,
  //                       ),
  //                     ),
  //                     Expanded(
  //                         child: Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 16),
  //                       child: CupertinoTextField(
  //                         controller: textController,
  //                         placeholder: 'Message',
  //                         onChanged: (value) => setState(() {
  //                           textController.text = value;
  //                         }),
  //                       ),
  //                     )),
  //                     GestureDetector(
  //                       onTap: () {
  //                         if (textController.text != '') {
  //                           setState(() {
  //                             chatMessages.add({
  //                               'type': ChatType.personal,
  //                               'message': textController.text,
  //                               'time':
  //                                   DateFormat('h:mm a').format(DateTime.now())
  //                             });
  //                             textController.text = '';
  //                           });
  //                         }
  //                       },
  //                       child: const Icon(
  //                         CupertinoIcons.paperplane,
  //                         color: CupertinoColors.black,
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.communityName),
        centerTitle: true,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.black,
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop(context),
        ),
      ),
      body: StreamBuilder<types.Room>(
        initialData: widget.communityRoom,
        stream: FirebaseChatCore.instance.room(widget.communityRoom.id),
        builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
          initialData: const [],
          stream: FirebaseChatCore.instance.messages(snapshot.data!),
          builder: (context, snapshot) => Chat(
            isAttachmentUploading: _isAttachmentUploading,
            messages: snapshot.data ?? [],
            onAttachmentPressed: _handleAttachmentPressed,
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            onSendPressed: _handleSendPressed,
            showUserAvatars: true,
            showUserNames: true,
            theme: const DefaultChatTheme(
              primaryColor: CupertinoColors.activeBlue,
              inputContainerDecoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.lightBackgroundGray,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
              inputTextColor: Colors.black,
              inputBackgroundColor: Colors.transparent,
              seenIcon: Text(
                'read',
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ),
            user: types.User(
              id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
            ),
          ),
        ),
        // body: Chat(
        //   messages: _messages,
        //   onAttachmentPressed: _handleAttachmentPressed,
        //   onMessageTap: _handleMessageTap,
        //   onPreviewDataFetched: _handlePreviewDataFetched,
        //   onSendPressed: _handleSendPressed,
        //   showUserAvatars: true,
        //   showUserNames: true,
        //   user: _user,
        //   theme: const DefaultChatTheme(
        //     primaryColor: CupertinoColors.activeBlue,
        //     inputContainerDecoration: BoxDecoration(
        //       boxShadow: [
        //         BoxShadow(
        //           color: CupertinoColors.lightBackgroundGray,
        //           spreadRadius: 5,
        //           blurRadius: 7,
        //           offset: Offset(0, 10), // changes position of shadow
        //         ),
        //       ],
        //     ),
        //     inputTextColor: Colors.black,
        //     inputBackgroundColor: Colors.transparent,
        //     seenIcon: Text(
        //       'read',
        //       style: TextStyle(
        //         fontSize: 10.0,
        //       ),
        //     ),
        //   ),
        // ),
      ));
}
