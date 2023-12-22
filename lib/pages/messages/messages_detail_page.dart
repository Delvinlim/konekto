import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:konekto/widgets/camera/camera_widget.dart';
import 'package:konekto/widgets/message/chat_message_widget.dart';
import 'package:intl/intl.dart';

// class MessagesDetailPage extends StatelessWidget {
//   const MessagesDetailPage(
//       {super.key, required this.communityName, required this.cameras});
//   final List<CameraDescription> cameras;
//   final String communityName;

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       theme: const CupertinoThemeData(brightness: Brightness.light),
//       home: MessagesDetail(communityName: communityName, cameras: cameras),
//     );
//   }
// }

class MessagesDetailPage extends StatefulWidget {
  const MessagesDetailPage({
    super.key,
    required this.communityName,
    required this.cameras,
  });
  final String communityName;
  final List<CameraDescription> cameras;

  @override
  State<MessagesDetailPage> createState() => _MessagesDetailPageState();
}

class _MessagesDetailPageState extends State<MessagesDetailPage> {
  var textController = TextEditingController(text: '');
  String formattedDate = DateFormat('h:mm a').format(DateTime.now());

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
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.communityName),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(context),
          ),
        ),
        child: SafeArea(
          // padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: SizedBox(
                height: 200.0,
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      for (var index = 0; index < chatMessages.length; index++)
                        ChatMessage(
                          textType: TextType.text,
                          type: chatMessages[index]['type'],
                          chatMessage: chatMessages[index]['message'],
                          chatTime: chatMessages[index]['time'],
                        ),
                      for (var index = 0; index < chatMessages.length; index++)
                        ChatMessage(
                          textType: TextType.text,
                          type: chatMessages[index]['type'],
                          chatMessage: chatMessages[index]['message'],
                          chatTime: chatMessages[index]['time'],
                        ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 16, vertical: 8),
                      //   child: Row(
                      //     children: [Image.asset('assets/images/event_1.png')],
                      //   ),
                      // ),
                    ]),
              )),
              // const CameraApp(),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.white,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 20), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context, rootNavigator: true)
                            .push(CupertinoPageRoute(
                                builder: (context) => CameraScreen(
                                      cameras: widget.cameras,
                                    ))),
                        child: const Icon(
                          CupertinoIcons.camera,
                          color: CupertinoColors.black,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CupertinoTextField(
                          controller: textController,
                          placeholder: 'Message',
                          onChanged: (value) => setState(() {
                            textController.text = value;
                          }),
                        ),
                      )),
                      GestureDetector(
                        onTap: () {
                          if (textController.text != '') {
                            setState(() {
                              chatMessages.add({
                                'type': ChatType.personal,
                                'message': textController.text,
                                'time':
                                    DateFormat('h:mm a').format(DateTime.now())
                              });
                              textController.text = '';
                            });
                          }
                        },
                        child: const Icon(
                          CupertinoIcons.paperplane,
                          color: CupertinoColors.black,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
    // child: Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //   ],
    // ));
  }
}
