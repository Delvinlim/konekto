import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/pages/auth/login_page.dart';
import 'package:konekto/pages/settings/account_settings_page.dart';
import 'package:konekto/pages/settings/auth_settings_page.dart';
import 'package:konekto/pages/settings/notification_settings_page.dart';
import 'package:konekto/pages/settings/report_settings_page.dart';
import 'package:konekto/pages/settings/terms_settings_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/widgets/item/settings_item_widget.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsState();
}

void launchWhatsapp(String message, String phone) async {
  String queryMessage = Uri.encodeComponent(message);
  String queryPhone = Uri.encodeComponent(phone);
  String whatsappUrl =
      "https://api.whatsapp.com/send/?phone=$queryPhone&text=$queryMessage&type=phone_number&app_absent=0";

  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
    await launchUrl(Uri.parse(whatsappUrl));
  }
}

const _storage = FlutterSecureStorage();

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    void launchWhatsapp(String message, String phone) async {
      String queryMessage = Uri.encodeComponent(message);
      String queryPhone = Uri.encodeComponent(phone);
      String whatsappUrl =
          "https://api.whatsapp.com/send/?phone=$queryPhone&text=$queryMessage&type=phone_number&app_absent=0";

      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      }
    }

    void _deleteAccount() async {
      dynamic accessToken = await _storage.read(key: 'jwtToken');
      try {
        Response res = await dioClient.delete('/auth/me',
            options:
                Options(headers: {"Authorization": 'Bearer $accessToken'}));
        final response = json.decode(res.toString());
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const LoginPage()));
      } on DioException catch (e) {
        //   toastification.show(
        //       context: context,
        //       title: e.message != null
        //           ? Text(e.response!.statusMessage!)
        //           : const Text("Server Error"),
        //       description: const Text(
        //         'Failed delete account, please contact Konekto',
        //         style: TextStyle(fontWeight: FontWeight.w500),
        //       ),
        //       autoCloseDuration: const Duration(seconds: 3),
        //       type: ToastificationType.error,
        //       style: ToastificationStyle.flatColored,
        //       alignment: Alignment.topCenter,
        //       direction: TextDirection.ltr,
        //       dragToClose: true,
        //       showProgressBar: false);
        // }
      }
    }

    void _showDeletePasswordDialog(BuildContext context) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Delete Account?'),
          content: const Text(
              'Are you sure want to delete your account? Once you confirm, your data from this account is permanently deleted'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDestructiveAction: true,
              onPressed: () {
                // Call API
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              onPressed: () {
                _deleteAccount();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }

    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          middle: const Text('Settings & Support'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => Navigator.of(context).pop(context),
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
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Color(0xffF6F6F6)),
                      // padding: const EdgeInsets.only(
                      //     top: 10, left: 10, right: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SettingsItem(
                            name: 'Account Information',
                            icon: const Icon(
                              CupertinoIcons.person,
                              color: CupertinoColors.black,
                            ),
                            callback: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const AccountSettingPage()));
                            },
                          ),
                          SettingsItem(
                            name: 'Change Password',
                            icon: const Icon(
                              CupertinoIcons.lock,
                              color: CupertinoColors.black,
                            ),
                            callback: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const AuthSettingPage()));
                            },
                          ),
                          SettingsItem(
                            name: 'Delete Account',
                            icon: const Icon(
                              CupertinoIcons.trash,
                              color: CupertinoColors.black,
                            ),
                            // callback: () {
                            //   _showDeletePasswordDialog(context);
                            // },
                            callback: () {
                              launchWhatsapp(
                                  'Halo, Saya ingin menghapus akun saya',
                                  '+62-822-8852-1900');
                            },
                          ),
                          SettingsItem(
                            name: 'Notification',
                            icon: const Icon(
                              CupertinoIcons.bell,
                              color: CupertinoColors.black,
                            ),
                            callback: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const NotificationSettingPage()));
                            },
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
            //                       const BorderRadius.all(Radius.circular(4)),
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
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Color(0xffF6F6F6)),
                      // padding: const EdgeInsets.only(
                      //     top: 10, left: 10, right: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SettingsItem(
                          //   name: 'Report',
                          //   icon: const Icon(
                          //     CupertinoIcons.flag,
                          //     color: CupertinoColors.black,
                          //   ),
                          //   callback: () {
                          //     Navigator.push(
                          //         context,
                          //         CupertinoPageRoute(
                          //             builder: (context) =>
                          //                 const ReportSettingPage()));
                          //   },
                          // ),
                          SettingsItem(
                            name: 'Live Support',
                            icon: const Icon(
                              CupertinoIcons.headphones,
                              color: CupertinoColors.black,
                            ),
                            callback: () {
                              launchWhatsapp(
                                  'Halo, saya ingin bertanya mengenai aplikasi Konekto',
                                  '+62-822-8852-1900');
                            },
                          ),
                          SettingsItem(
                            name: 'Term & Policies',
                            icon: const Icon(
                              CupertinoIcons.doc,
                              color: CupertinoColors.black,
                            ),
                            callback: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const TermsSettingPage()));
                            },
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
