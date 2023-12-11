import 'package:flutter/cupertino.dart';

class TermsSettingPage extends StatelessWidget {
  const TermsSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: TermsSetting(),
    );
  }
}

class TermsSetting extends StatefulWidget {
  const TermsSetting({super.key});

  @override
  State<TermsSetting> createState() => _TermsSettingState();
}

class _TermsSettingState extends State<TermsSetting> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Term & Policies'),
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
