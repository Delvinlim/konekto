import 'package:flutter/cupertino.dart';
import 'package:konekto/pages/communities/community_page.dart';
import 'package:konekto/pages/explore/explore_page.dart';
import 'package:konekto/pages/home/home_page.dart';
import 'package:konekto/pages/messages/messages_page.dart';
import 'package:konekto/pages/profile/profile_page.dart';

/// Flutter code sample for [CupertinoTabBar].

// void main() => runApp(const KonektoTabBarApp());

class KonektoTabBarApp extends StatelessWidget {
  const KonektoTabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: KonektoTabBar(),
    );
  }
}

class KonektoTabBar extends StatelessWidget {
  const KonektoTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 60,
        backgroundColor: CupertinoColors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/home.png'),
              activeIcon: Image.asset('assets/icons/home-active.png')),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/search.png'),
              activeIcon: Image.asset('assets/icons/search-active.png')),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/hall.png'),
              activeIcon: Image.asset('assets/icons/hall-active.png')),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/chat.png'),
              activeIcon: Image.asset('assets/icons/chat-active.png')),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/user.png'),
              activeIcon: Image.asset('assets/icons/user-active.png')),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return const Home();
          case 1:
            return const Explore();
          case 2:
            return const Communities();
          case 3:
            return const Messages();
          case 4:
            return const Profile();
          default:
            return const Home();
        }
        // return CupertinoTabView(
        //   builder: (BuildContext context) {
        //     return Center(
        //       child: Text('Content of tab $index'),
        //     );
        //   },
        // );
      },
    );
  }
}
