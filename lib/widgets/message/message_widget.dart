import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:konekto/pages/messages/messages_detail_page.dart';

class Message extends StatefulWidget {
  const Message(
      {super.key,
      required this.communityName,
      required this.communityImage,
      required this.communityRoom,
      required this.cameras});
  final String communityName;
  final String communityImage;
  final Room communityRoom;
  final List<CameraDescription> cameras;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                widget.communityImage,
                height: 35.0,
                width: 35.0,
              ),
            ),
          ),
          Expanded(
              child: GestureDetector(
            onTap: () => Navigator.of(context, rootNavigator: true)
                .push(CupertinoPageRoute(
                    builder: (context) => MessagesDetailPage(
                          communityRoom: widget.communityRoom,
                          communityName: widget.communityName,
                        ))),
            // communityName: widget.communityName,
            // cameras: widget.cameras,
            child: Container(
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.communityName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        '105 Members',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '12:00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff0689FF),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
