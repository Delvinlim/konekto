import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/widgets/message/comment_widget.dart';

import '../../widgets/card/communities_card_widget.dart';

class CommunitiesPostPage extends StatelessWidget {
  const CommunitiesPostPage({super.key, required this.communityName});
  final String communityName;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: CommunitiesPost(communityName: communityName),
    );
  }
}

class CommunitiesPost extends StatefulWidget {
  const CommunitiesPost({super.key, required this.communityName});
  final String communityName;

  @override
  State<CommunitiesPost> createState() => _CommunitiesPostState();
}

class _CommunitiesPostState extends State<CommunitiesPost> {
  var textController = TextEditingController(text: '');
  final List<Map> commentsMessage = [
    {'message': 'Semangat Bang'},
    {'message': 'Nice Banget Bang'},
  ];
  final List<Widget> comments = [
    const Comment(
      message: 'Semangat Bang',
    ),
    const Comment(
      message: 'Nice Banget Bang',
    ),
  ];

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.communityName),
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.black,
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop(context),
        ),
      ),
      child: Column(
        children: [
          ForYouCommunitiesCard(
            communityName: widget.communityName,
            communityImage: 'assets/images/communities/odba.png',
            creatorName: 'Delvin Lim',
          ),
          const Divider(
            height: 4,
            color: CupertinoColors.black,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,

                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var index = 0; index < commentsMessage.length; index++)
                      Comment(
                        message: commentsMessage[index]['message'],
                      )
                  ],
                ),
              ),
            ),
          )),
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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    // onTap: () => Navigator.of(context, rootNavigator: true)
                    //     .push(CupertinoPageRoute(
                    //         builder: (context) => CameraScreen(
                    //               cameras: widget.cameras,
                    //             ))),
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
                      setState(() {
                        commentsMessage.add({'message': textController.text});
                      });
                      textController.text = '';
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
    );
  }
}
