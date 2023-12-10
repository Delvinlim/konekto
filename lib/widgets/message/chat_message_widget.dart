import 'package:flutter/cupertino.dart';

enum ChatType { personal, opposite }

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.type});
  final ChatType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection:
            type.name == 'personal' ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'assets/images/profile.png',
                height: 35.0,
                width: 35.0,
              ),
            ),
          ),
          Expanded(
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  // color: Color(0xFF0689FF),
                  color: type.name == 'personal'
                      ? const Color(0xFF0689FF)
                      : const Color(0xFFF6F6F6),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nanti malam jam 7 jangan lupa, ada tanding persahabatan dengan Barbar FC',
                        style: TextStyle(
                          color: type.name == 'personal'
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '3:00 PM',
                        style: TextStyle(
                          color: type.name == 'personal'
                              ? CupertinoColors.lightBackgroundGray
                              : const Color(0xFF757575),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
