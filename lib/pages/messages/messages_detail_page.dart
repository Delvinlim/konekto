import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:konekto/widgets/camera/camera_widget.dart';
import 'package:konekto/widgets/message/chat_message_widget.dart';

class MessagesDetailPage extends StatelessWidget {
  const MessagesDetailPage(
      {super.key, required this.communityName, required this.cameras});
  final List<CameraDescription> cameras;
  final String communityName;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: MessagesDetail(communityName: communityName, cameras: cameras),
    );
  }
}

class MessagesDetail extends StatefulWidget {
  const MessagesDetail(
      {super.key, required this.communityName, required this.cameras});
  final String communityName;
  final List<CameraDescription> cameras;

  @override
  State<MessagesDetail> createState() => _MessagesDetailState();
}

class _MessagesDetailState extends State<MessagesDetail> {
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
                  children: const [
                    ChatMessage(type: ChatType.opposite),
                    ChatMessage(type: ChatType.opposite),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.opposite),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.opposite),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.personal),
                    ChatMessage(type: ChatType.opposite),
                    ChatMessage(type: ChatType.opposite),
                  ],
                ),
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
                          color: Colors.black,
                        ),
                      ),
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: CupertinoTextField(
                          placeholder: 'Message',
                        ),
                      )),
                      // CupertinoSearchTextField(
                      //   controller: textController,
                      //   placeholder: 'Search',
                      //   onTap: () {
                      //     // Navigate to the blank page on search submit
                      //     Navigator.push(
                      //       context,
                      //       CupertinoPageRoute(
                      //         builder: (context) => const ExploreResult(),
                      //       ),
                      //     );
                      //   },
                      // ),
                      const Icon(
                        CupertinoIcons.share,
                        color: Colors.black,
                      ),
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
