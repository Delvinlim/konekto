import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:konekto/pages/auth/forget_password_page.dart';
import 'package:konekto/pages/notifications/notification_page.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:konekto/widgets/card/event_card_widget.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Widget homeSlider = SizedBox(
  height: 200,
  child: Swiper(
    itemBuilder: (BuildContext context, int index) {
      return Image.network(
        "https://via.placeholder.com/320x200",
        fit: BoxFit.fill,
      );
    },
    itemCount: 5,
    pagination: const SwiperPagination(),
    control: const SwiperControl(),
  ),
);

Widget homeCommunityCategories = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                border: KonektoBorder.all(color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color(0xffD9D9D9)),
            child: Image.asset(
              'assets/images/football.png',
              height: 50.0,
              width: 50.0,
            ),
          ),
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                border: KonektoBorder.all(color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color(0xffD9D9D9)),
            child: Image.asset(
              'assets/images/football.png',
              height: 50.0,
              width: 50.0,
            ),
          ),
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                border: KonektoBorder.all(color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color(0xffD9D9D9)),
            child: Image.asset(
              'assets/images/football.png',
              height: 50.0,
              width: 50.0,
            ),
          ),
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                border: KonektoBorder.all(color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color(0xffD9D9D9)),
            child: Image.asset(
              'assets/images/football.png',
              height: 50.0,
              width: 50.0,
            ),
          ),
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                border: KonektoBorder.all(color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color(0xffD9D9D9)),
            child: Image.asset(
              'assets/images/football.png',
              height: 50.0,
              width: 50.0,
            ),
          ),
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                border: KonektoBorder.all(color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color(0xffD9D9D9)),
            child: Image.asset(
              'assets/images/football.png',
              height: 50.0,
              width: 50.0,
            ),
          ),
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                border: KonektoBorder.all(color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color(0xffD9D9D9)),
            child: Image.asset(
              'assets/images/football.png',
              height: 50.0,
              width: 50.0,
            ),
          ),
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                border: KonektoBorder.all(color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color(0xffD9D9D9)),
            child: Image.asset(
              'assets/images/football.png',
              height: 50.0,
              width: 50.0,
            ),
          ),
        ]));

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // Uncomment to change the background color
      // backgroundColor: CupertinoColors.systemPink,
      // navigationBar: const CupertinoNavigationBar(
      //   middle: Text('Home'),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40.0, horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            'assets/images/profile.png',
                            height: 50.0,
                            width: 50.0,
                          ),
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning,',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Delvin Lim',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40.0, horizontal: 10.0),
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const NotificationsPage()));
                          },
                          child: const Icon(
                            CupertinoIcons.bell,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          homeSlider,
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordPage()));
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(color: Colors.black87),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          homeCommunityCategories,
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Event',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         GestureDetector(
                //           onTap: () {
                //             Navigator.push(
                //                 context,
                //                 CupertinoPageRoute(
                //                     builder: (context) =>
                //                         const ForgetPasswordPage()));
                //           },
                //           child: const Text(
                //             'See All',
                //             style: TextStyle(color: Colors.black87),
                //           ),
                //         )
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          const EventCard(),
        ],
      ),
    );
  }
}
