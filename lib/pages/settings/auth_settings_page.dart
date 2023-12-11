import 'package:flutter/cupertino.dart';

class AuthSettingPage extends StatelessWidget {
  const AuthSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: AuthSetting(),
    );
  }
}

class AuthSetting extends StatefulWidget {
  const AuthSetting({super.key});

  @override
  State<AuthSetting> createState() => _AuthSettingState();
}

class _AuthSettingState extends State<AuthSetting> {
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
