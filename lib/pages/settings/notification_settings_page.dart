import 'package:flutter/cupertino.dart';
import 'package:konekto/widgets/item/notification_settings_item_widget.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSettingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Notification'),
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
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xffF6F6F6)),
                    // padding: const EdgeInsets.only(
                    //     top: 10, left: 10, right: 10, bottom: 10),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NotificationSettingsItem(name: 'Likes', value: true),
                        NotificationSettingsItem(name: 'Comments', value: true),
                        NotificationSettingsItem(
                            name: 'Announcement', value: true),
                        NotificationSettingsItem(
                            name: 'Community Post', value: true),
                        // AccountSettingsItem(name: 'Name', value: 'Delvin Lim'),
                        // AccountSettingsItem(
                        //     name: 'Username', value: '@delvinlim_'),
                        // AccountSettingsItem(
                        //     name: 'Email', value: 'delvin@example.com'),
                        // AccountSettingsItem(
                        //     name: 'Date of Birth', value: 'March 25, 2003'),
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
