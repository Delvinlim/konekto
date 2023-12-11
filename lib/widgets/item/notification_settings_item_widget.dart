import 'package:flutter/cupertino.dart';

class NotificationSettingsItem extends StatefulWidget {
  const NotificationSettingsItem(
      {super.key, required this.name, required this.value});
  final String name;
  final bool value;

  @override
  State<NotificationSettingsItem> createState() =>
      _NotificationSettingsItemState();
}

class _NotificationSettingsItemState extends State<NotificationSettingsItem> {
  late bool switchValue;

  @override
  void initState() {
    super.initState();
    switchValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: switchValue,
                  activeColor: CupertinoColors.activeBlue,
                  onChanged: (bool? value) {
                    setState(() {
                      switchValue = value ?? false;
                    });
                  },
                ),
              )
            ],
          ),
        ));
  }
}
