import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/auth/login_page.dart';
import 'package:konekto/pages/settings/settings_page.dart';

void _logout(BuildContext context) {
  Navigator.pushAndRemoveUntil(context,
      CupertinoPageRoute(builder: (BuildContext context) {
    return const LoginPage();
  }), (r) {
    return false;
  });
}

void _showSignouttDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure want to sign out?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
            _logout(context);
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

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
            onTap: () => {
              Navigator.of(context, rootNavigator: true).pop(context),
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => const SettingsPage()))
            },
          ),
          ListTile(
            title: const Text(
              'Sign Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.logout),
            onTap: () => _showSignouttDialog(context),
          ),
        ],
      ),
    ));
  }
}
