import 'package:flutter/cupertino.dart';
import 'package:konekto/widgets/card/report_settings_card_widget.dart';

class ReportSettingPage extends StatelessWidget {
  const ReportSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: ReportSetting(),
    );
  }
}

class ReportSetting extends StatefulWidget {
  const ReportSetting({super.key});

  @override
  State<ReportSetting> createState() => _ReportSettingState();
}

class _ReportSettingState extends State<ReportSetting> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          middle: const Text('Report'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(context),
            },
          ),
        ),
        child: SafeArea(
            child: ListView(
          children: const [
            ReportSettingsCard(
              state: 'Waiting',
            ),
            ReportSettingsCard(
              state: 'Waiting',
            ),
            ReportSettingsCard(
              state: 'Approved',
            ),
            ReportSettingsCard(
              state: 'Rejected',
            ),
            ReportSettingsCard(
              state: 'Approved',
            ),
          ],
        )));
  }
}
