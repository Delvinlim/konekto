import 'package:flutter/material.dart';

class ProfileModal extends StatelessWidget {
  const ProfileModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.settings),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: const Text(
              'Sign Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.logout),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    ));
  }
}
