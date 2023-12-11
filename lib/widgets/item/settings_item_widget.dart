import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem(
      {super.key, required this.name, required this.icon, required this.page});
  final String name;
  final Icon icon;
  final Widget page;

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => widget.page));
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: widget.icon),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: CupertinoColors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Icon(
                CupertinoIcons.chevron_right,
                color: Colors.black,
              ),
            ],
          ),
        ));
  }
}
