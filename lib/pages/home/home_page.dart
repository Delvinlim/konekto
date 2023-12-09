import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:konekto/pages/notifications/notification_page.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:konekto/widgets/card/event_card_widget.dart';
import 'package:konekto/widgets/modals/category_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
                            showCupertinoModalBottomSheet(
                                expand: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                      controller:
                                          ModalScrollController.of(context),
                                      child: const CategoryModal(),
                                    ));
                            // Navigator.push(
                            //     context,
                            //     CupertinoPageRoute(
                            //         builder: (context) =>
                            //             const ForgetPasswordPage()));
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
              ],
            ),
          ),
          const SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  EventCard(),
                  EventCard(),
                  EventCard(),
                  EventCard(),
                  EventCard(),
                  EventCard(),
                  EventCard(),
                  EventCard(),
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
          homeCommunityCategories,
        ],
      ),
    ));
  }
}
