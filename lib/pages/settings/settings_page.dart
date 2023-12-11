import 'package:flutter/cupertino.dart';
import 'package:konekto/pages/explore/explore_page.dart';
import 'package:konekto/pages/home/home_page.dart';
import 'package:konekto/pages/settings/account_settings_page.dart';
import 'package:konekto/pages/settings/auth_settings_page.dart';
import 'package:konekto/pages/settings/notification_settings_page.dart';
import 'package:konekto/pages/settings/report_settings_page.dart';
import 'package:konekto/pages/settings/terms_settings_page.dart';
import 'package:konekto/widgets/item/settings_item_widget.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const SettingsPage());

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          middle: const Text('Settings & Support'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(context),
          ),
        ),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Column(
            //       children: [
            //         Row(
            //           children: [
            //             Container(
            //               padding: const EdgeInsets.only(
            //                   top: 10, left: 10, right: 10, bottom: 10),
            //               child: const Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     'Settings & Support',
            //                     style: TextStyle(
            //                         fontSize: 24, fontWeight: FontWeight.bold),
            //                   )
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color(0xffF6F6F6)),
                      // padding: const EdgeInsets.only(
                      //     top: 10, left: 10, right: 10, bottom: 10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SettingsItem(
                            name: 'Account Information',
                            icon: Icon(
                              CupertinoIcons.person,
                              color: CupertinoColors.black,
                            ),
                            page: AccountSettingPage(),
                          ),
                          SettingsItem(
                            name: 'Change Password',
                            icon: Icon(
                              CupertinoIcons.lock,
                              color: CupertinoColors.black,
                            ),
                            page: AuthSettingPage(),
                          ),
                          SettingsItem(
                            name: 'Delete Account',
                            icon: Icon(
                              CupertinoIcons.trash,
                              color: CupertinoColors.black,
                            ),
                            page: ExplorePage(),
                          ),
                          SettingsItem(
                            name: 'Notification',
                            icon: Icon(
                              CupertinoIcons.bell,
                              color: CupertinoColors.black,
                            ),
                            page: NotificationSettingPage(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Column(
            //       children: [
            //         Row(
            //           children: [
            //             Container(
            //               decoration: BoxDecoration(
            //                   border: KonektoBorder.all(
            //                       color: CupertinoColors.lightBackgroundGray),
            //                   borderRadius:
            //                       const BorderRadius.all(Radius.circular(8)),
            //                   color: const Color(0xffD9D9D9)),
            //               padding: const EdgeInsets.only(
            //                   top: 10, left: 10, right: 10, bottom: 10),
            //               child: const Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   SettingsItem(),
            //                   SettingsItem(),
            //                   SettingsItem(),
            //                   SettingsItem(),
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Support & About',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color(0xffF6F6F6)),
                      // padding: const EdgeInsets.only(
                      //     top: 10, left: 10, right: 10, bottom: 10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SettingsItem(
                            name: 'Report',
                            icon: Icon(
                              CupertinoIcons.flag,
                              color: CupertinoColors.black,
                            ),
                            page: ReportSettingPage(),
                          ),
                          SettingsItem(
                            name: 'Live Support',
                            icon: Icon(
                              CupertinoIcons.headphones,
                              color: CupertinoColors.black,
                            ),
                            page: ExplorePage(),
                          ),
                          SettingsItem(
                            name: 'Term & Policies',
                            icon: Icon(
                              CupertinoIcons.doc,
                              color: CupertinoColors.black,
                            ),
                            page: TermsSettingPage(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
