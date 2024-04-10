import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/widgets/appbar/app_bar_widget.dart';
import 'package:konekto/widgets/message/comment_widget.dart';

// class CommunitiesPostCreationPage extends StatelessWidget {
//   const CommunitiesPostCreationPage({super.key, required this.communityName});
//   final String communityName;

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       theme: const CupertinoThemeData(brightness: Brightness.light),
//       home: CommunitiesPostCreationPage(communityName: communityName),
//     );
//   }
// }

class CommunitiesPostCreationPage extends StatefulWidget {
  const CommunitiesPostCreationPage({super.key, required this.communityName});
  final String communityName;

  @override
  State<CommunitiesPostCreationPage> createState() =>
      _CommunitiesPostCreationState();
}

class _CommunitiesPostCreationState extends State<CommunitiesPostCreationPage> {
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Comment(
                    message: 'Semangat Bang',
                  ),
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
                ],
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(bottom: 16),
            child: const CupertinoTextField(
              maxLines: 8,
              placeholder: 'Write something',
            ),
          ),
          CupertinoButton(
              color: Colors.blue.shade600,
              child: const Text('Post',
                  style: TextStyle(
                      fontSize: 16,
                      // color: CupertinoColors.black,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const KonektoTabBar()),
                    ((route) => false));
              }),
        ],
      ),
    );
  }
}
