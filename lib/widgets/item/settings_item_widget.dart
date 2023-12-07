import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({super.key, required this.name, required this.icon});
  final String name;
  final Icon icon;

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 8), child: widget.icon),
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
    );
  }
}
