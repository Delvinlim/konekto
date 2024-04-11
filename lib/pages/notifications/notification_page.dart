import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/widgets/card/notification_card_widget.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const NotificationsPage());

enum NotificationType { all, system, community }

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationType _selectedSegment = NotificationType.all;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        // navigationBar: const CupertinoNavigationBar(
        //   middle: Text('Home'),
        // ),
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Notification'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => Navigator.of(context).pop(context),
          ),
        ),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
                width: double.infinity,
                child: SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.10,
                  child: CupertinoSlidingSegmentedControl<NotificationType>(
                    backgroundColor: CupertinoColors.systemGrey2,
                    thumbColor: Colors.blue.shade600,
                    groupValue: _selectedSegment,
                    onValueChanged: (NotificationType? value) {
                      if (value != null) {
                        setState(() {
                          _selectedSegment = value;
                        });
                      }
                    },
                    children: const <NotificationType, Widget>{
                      NotificationType.all: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'All',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                      NotificationType.system: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'System',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                      NotificationType.community: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Community',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                    },
                  ),
                )),
            Expanded(
                child: SizedBox(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  if (_selectedSegment.name == 'system') ...[
                    const SystemNotificationCard(
                      notificationMessage:
                          "Looking for affordable and reliable community costumes? Tania Store has the answer, as we can customize anything from clothing to discounted merchandise up to 60%!",
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Join us for an electrifying showdown as Makaras takes on Bukoki in the match of the year! Don't miss the action. It's a clash you won't want to miss! ⚽🔥 #MakarasVsBukoki #GameOn",
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Build your own community, and watch the benefits multiply. It's more than just a group; it's a world of opportunities waiting to unfold. 🌱🌍 #CommunityBuilders",
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Build your own community, and watch the benefits multiply. It's more than just a group; it's a world of opportunities waiting to unfold. 🌱🌍 #CommunityBuilders",
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Build your own community, and watch the benefits multiply. It's more than just a group; it's a world of opportunities waiting to unfold. 🌱🌍 #CommunityBuilders",
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Supercharge your community's growth with premium support, and welcome a wave of new members! Elevate, expand, and excel together. 🚀💪 #CommunityGrowth",
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Take control of your community by fine-tuning all the settings to your exact preferences. When you have the tools to shape your space, you can create something truly special. 🎯✨ #CommunityControl",
                    ),
                  ] else if (_selectedSegment.name == 'community') ...[
                    const NotificationCard(
                      communityName: 'ODBA',
                      notificationMessage:
                          'Rohim is currently posted something in ODBA',
                      communityImage: 'assets/images/communities/odba.png',
                    ),
                    const NotificationCard(
                      communityName: 'PSEG Fossil',
                      notificationMessage:
                          'Matunda is currently posted something in PSEG Fossil',
                      communityImage:
                          'assets/images/communities/pseg_fossil.png',
                    ),
                    const NotificationCard(
                      communityName: 'Buaran',
                      notificationMessage:
                          'Matunda is currently posted something in Buaran',
                      communityImage: 'assets/images/communities/buaran.png',
                    ),
                    const NotificationCard(
                      communityName: 'Inter',
                      notificationMessage:
                          'Rafika is currently posted something in Inter',
                      communityImage: 'assets/images/communities/inter.png',
                    ),
                    const NotificationCard(
                      communityName: 'Super Slasher Aquatics',
                      notificationMessage:
                          'Monicari is currently posted something in Super Slasher Aquatics',
                      communityImage:
                          'assets/images/communities/super_slasher_aquatics.png',
                    ),
                    const NotificationCard(
                      communityName: 'Rasson',
                      notificationMessage:
                          'Someone is currently posted something in Rasson',
                      communityImage: 'assets/images/communities/rasson.png',
                    ),
                    const NotificationCard(
                      communityName: 'NorthArm',
                      notificationMessage:
                          'Fitri is currently posted something in NorthArm',
                      communityImage: 'assets/images/communities/northarm.png',
                    ),
                    const NotificationCard(
                      communityName: 'Spartans',
                      notificationMessage:
                          'Admin is currently posted something in Spartans',
                      communityImage: 'assets/images/communities/spartans.png',
                    ),
                    const NotificationCard(
                      communityName: 'Devils Reject Nation',
                      notificationMessage:
                          'Tomas is currently posted something in Devils Reject Nation',
                      communityImage: 'assets/images/communities/dnr.png',
                    ),
                    const NotificationCard(
                      communityName: 'Sydney Real',
                      notificationMessage:
                          'Robby is currently posted something in Sydney Real',
                      communityImage:
                          'assets/images/communities/sydney_real.png',
                    ),
                  ] else ...[
                    const NotificationCard(
                      communityName: 'ODBA',
                      notificationMessage:
                          'Rohim is currently posted something in ODBA',
                      communityImage: 'assets/images/communities/odba.png',
                    ),
                    const NotificationCard(
                      communityName: 'PSEG Fossil',
                      notificationMessage:
                          'Matunda is currently posted something in PSEG Fossil',
                      communityImage:
                          'assets/images/communities/pseg_fossil.png',
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Looking for affordable and reliable community costumes? Tania Store has the answer, as we can customize anything from clothing to discounted merchandise up to 60%!",
                    ),
                    const NotificationCard(
                      communityName: 'Buaran',
                      notificationMessage:
                          'Matunda is currently posted something in Buaran',
                      communityImage: 'assets/images/communities/buaran.png',
                    ),
                    const NotificationCard(
                      communityName: 'Inter',
                      notificationMessage:
                          'Rafika is currently posted something in Inter',
                      communityImage: 'assets/images/communities/inter.png',
                    ),
                    const NotificationCard(
                      communityName: 'Super Slasher Aquatics',
                      notificationMessage:
                          'Monicari is currently posted something in Super Slasher Aquatics',
                      communityImage:
                          'assets/images/communities/super_slasher_aquatics.png',
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Join us for an electrifying showdown as Makaras takes on Bukoki in the match of the year! Don't miss the action. It's a clash you won't want to miss! ⚽🔥 #MakarasVsBukoki #GameOn",
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Build your own community, and watch the benefits multiply. It's more than just a group; it's a world of opportunities waiting to unfold. 🌱🌍 #CommunityBuilders",
                    ),
                    const NotificationCard(
                      communityName: 'Rasson',
                      notificationMessage:
                          'Someone is currently posted something in Rasson',
                      communityImage: 'assets/images/communities/rasson.png',
                    ),
                    const NotificationCard(
                      communityName: 'NorthArm',
                      notificationMessage:
                          'Fitri is currently posted something in NorthArm',
                      communityImage: 'assets/images/communities/northarm.png',
                    ),
                    const NotificationCard(
                      communityName: 'Spartans',
                      notificationMessage:
                          'Admin is currently posted something in Spartans',
                      communityImage: 'assets/images/communities/spartans.png',
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Build your own community, and watch the benefits multiply. It's more than just a group; it's a world of opportunities waiting to unfold. 🌱🌍 #CommunityBuilders",
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Build your own community, and watch the benefits multiply. It's more than just a group; it's a world of opportunities waiting to unfold. 🌱🌍 #CommunityBuilders",
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Supercharge your community's growth with premium support, and welcome a wave of new members! Elevate, expand, and excel together. 🚀💪 #CommunityGrowth",
                    ),
                    const NotificationCard(
                      communityName: 'Devils Reject Nation',
                      notificationMessage:
                          'Tomas is currently posted something in Devils Reject Nation',
                      communityImage: 'assets/images/communities/dnr.png',
                    ),
                    const SystemNotificationCard(
                      notificationMessage:
                          "Take control of your community by fine-tuning all the settings to your exact preferences. When you have the tools to shape your space, you can create something truly special. 🎯✨ #CommunityControl",
                    ),
                    const NotificationCard(
                      communityName: 'Sydney Real',
                      notificationMessage:
                          'Robby is currently posted something in Sydney Real',
                      communityImage:
                          'assets/images/communities/sydney_real.png',
                    ),
                  ],
                ],
              ),
            ))
          ],
        ));
  }
}
