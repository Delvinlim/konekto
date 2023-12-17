import 'package:flutter/cupertino.dart';

class AuthSettingPage extends StatefulWidget {
  const AuthSettingPage({super.key});

  @override
  State<AuthSettingPage> createState() => _AuthSettingState();
}

class _AuthSettingState extends State<AuthSettingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Change Password'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(context),
            },
          ),
        ),
        child: Container());
  }
}
