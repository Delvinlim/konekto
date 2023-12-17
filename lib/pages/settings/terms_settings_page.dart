import 'package:flutter/cupertino.dart';

class TermsSettingPage extends StatefulWidget {
  const TermsSettingPage({super.key});

  @override
  State<TermsSettingPage> createState() => _TermsSettingState();
}

class _TermsSettingState extends State<TermsSettingPage> {
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
