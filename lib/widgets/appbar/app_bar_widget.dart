import 'package:flutter/cupertino.dart';
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.mail),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return const Home();
          case 1:
            return const Explore();
          case 2:
            return const Messages();
          case 3:
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
