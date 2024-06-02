import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:konekto/models/profile_response.dart';
import 'package:konekto/widgets/item/account_settings_item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({super.key});

  @override
  State<AccountSettingPage> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSettingPage> {
  ProfileResponse profile =
      ProfileResponse(id: '', name: '', username: '', email: '');

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  void _fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userPref = prefs.getString('user');
    print('profile user..');
    print(userPref);
    ProfileResponse profileResponse =
        ProfileResponse.fromJson(json.decode(userPref!));

    setState(() {
      profile = profileResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Account Information'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(context),
            },
          ),
        ),
        child: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                      'Information Detail',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        AccountSettingsItem(
                          name: 'Name',
                          value: profile.name ?? '',
                          identifier: 'name',
                        ),
                        AccountSettingsItem(
                          name: 'Username',
                          value: profile.username ?? '',
                          identifier: 'username',
                        ),
                        AccountSettingsItem(
                          name: 'Email',
                          value: profile.email ?? '',
                          identifier: 'email',
                        ),
                        // AccountSettingsItem(
                        //   name: 'Date of Birth',
                        //   value: 'March 25, 2003',
                        //   identifier: 'dob',
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ])));
  }
}
