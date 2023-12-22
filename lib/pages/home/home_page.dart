import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:konekto/pages/communities/community_list_page.dart';
import 'package:konekto/pages/notifications/notification_page.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:konekto/widgets/card/event_card_widget.dart';
import 'package:konekto/widgets/modals/category_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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

final List imageList = [
  'assets/images/banner_1.png',
  'assets/images/banner_2.png',
  'assets/images/banner_3.png',
];

Widget homeSlider = SizedBox(
  height: 200,
  child: Swiper(
    itemBuilder: (BuildContext context, int index) {
      return Image.asset(
        imageList[index],
        fit: BoxFit.fill,
      );
      // return Image.network(
      //   "https://via.placeholder.com/320x200",
      //   fit: BoxFit.fill,
      // );
    },
    itemCount: 3,
    pagination: const SwiperPagination(),
    control: const SwiperControl(),
  ),
);

Widget homeCommunityCategories(context) {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CommunitiesListPage(
                              categoryName: 'Football',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffD9D9D9)),
                child: Image.asset(
                  'assets/images/categories/football.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CommunitiesListPage(
                              categoryName: 'Volleyball',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffD9D9D9)),
                child: Image.asset(
                  'assets/images/categories/volleyball.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CommunitiesListPage(
                              categoryName: 'Basketball',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffD9D9D9)),
                child: Image.asset(
                  'assets/images/categories/basketball.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CommunitiesListPage(
                              categoryName: 'Billiard',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffD9D9D9)),
                child: Image.asset(
                  'assets/images/categories/billiard.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CommunitiesListPage(
                              categoryName: 'Badminton',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffD9D9D9)),
                child: Image.asset(
                  'assets/images/categories/badminton.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CommunitiesListPage(
                              categoryName: 'Swimming',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffD9D9D9)),
                child: Image.asset(
                  'assets/images/categories/swimming.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CommunitiesListPage(
                              categoryName: 'Tennis',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffD9D9D9)),
                child: Image.asset(
                  'assets/images/categories/tennis.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CommunitiesListPage(
                              categoryName: 'Gaming',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffD9D9D9)),
                child: Image.asset(
                  'assets/images/categories/gaming.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
          ]));
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        // navigationBar: const CupertinoNavigationBar(
        //   middle: Text('Home'),
        // ),
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
                      Container(
                        padding: const EdgeInsets.only(
                            top: 30, left: 10, right: 10, bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            'assets/images/profile.png',
                            height: 50.0,
                            width: 50.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: const Column(
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
                        ),
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
                        padding: const EdgeInsets.only(
                            top: 30, left: 10, right: 10, bottom: 10),
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) =>
                                    const NotificationsPage()));
                          },
                          child: const Icon(
                            CupertinoIcons.bell,
                            color: CupertinoColors.black,
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
                            showCupertinoModalBottomSheet(
                                expand: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                      controller:
                                          ModalScrollController.of(context),
                                      child: const CategoryModal(),
                                    ));
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(color: CupertinoColors.black),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          homeCommunityCategories(context),
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
              ],
            ),
          ),
          const SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  EventCard(
                    eventName: '2023 Kepri Cup',
                    eventImage: 'assets/images/events/kepri_cup.png',
                  ),
                  EventCard(
                    eventName: 'Batam Drawing',
                    eventImage: 'assets/images/events/batam_drawing.png',
                  ),
                  EventCard(
                    eventName: 'UIB Run',
                    eventImage: 'assets/images/events/ika_uib.png',
                  ),
                  EventCard(
                    eventName: '2023 Kepri Cup',
                    eventImage: 'assets/images/events/kepri_cup.png',
                  ),
                  EventCard(
                    eventName: 'Batam Drawing',
                    eventImage: 'assets/images/events/batam_drawing.png',
                  ),
                  EventCard(
                    eventName: 'UIB Run',
                    eventImage: 'assets/images/events/ika_uib.png',
                  ),
                ],
              ),
            ),
          ),
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
                              'Favorites',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          homeCommunityCategories(context),
        ],
      ),
    ));
  }
}
