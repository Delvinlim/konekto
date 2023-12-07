import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/settings/settings_page.dart';

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
            onTap: () => Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(builder: (context) => const SettingsPage())),
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
