import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:konekto/models/profile_response.dart';
import 'package:konekto/pages/communities/community_list_page.dart';
import 'package:konekto/pages/notifications/notification_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:konekto/widgets/card/event_card_widget.dart';
import 'package:konekto/widgets/modals/category_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toastification/toastification.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
        theme: CupertinoThemeData(brightness: Brightness.light), home: Home());
    // home: DoubleBackToCloseApp(
    //     snackBar: SnackBar(
    //       content: Text('Tap back again to leave'),
    //     ),
    //     child: Home()));q
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

const _storage = FlutterSecureStorage();

final List imageList = [
  'assets/images/banner_1.png',
  'assets/images/banner_2.png',
  'assets/images/banner_3.png',
];

Widget homeSlider = SizedBox(
  height: 200,
  child: Swiper(
    itemBuilder: (BuildContext context, int index) {
      // Ideal size 320 x 200 or 16:9 image
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          imageList[index],
          fit: BoxFit.fill,
        ),
      );
    },
    itemCount: 3,
    viewportFraction: 0.8,
    scale: 0.9,
    autoplay: true,
    pagination: const SwiperPagination(),
    // control: const SwiperControl(),
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
                        builder: (context) => const CommunitiesList(
                              categoryName: 'Football',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: const Color(0xffD9D9D9)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(
                    'assets/images/categories/football.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CommunitiesList(
                              categoryName: 'Volleyball',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                        builder: (context) => const CommunitiesList(
                              categoryName: 'Basketball',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                        builder: (context) => const CommunitiesList(
                              categoryName: 'Billiard',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                        builder: (context) => const CommunitiesList(
                              categoryName: 'Badminton',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                        builder: (context) => const CommunitiesList(
                              categoryName: 'Swimming',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                        builder: (context) => const CommunitiesList(
                              categoryName: 'Tennis',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                        builder: (context) => const CommunitiesList(
                              categoryName: 'Gaming',
                            )));
              },
              child: Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: KonektoBorder.all(color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
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
  // Skeletonizer Init
  bool isProfileFetched = false;
  bool isBannerFetched = false;
  bool isCategoriesFetched = false;
  bool isEventsFetched = false;
  late ProfileResponse profile = ProfileResponse(id: '', name: '', email: '');
  late String greeting;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
    setState(() {
      greeting = getGreetings();
    });
  }

  String getGreetings() {
    var hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 16) {
      return 'Good Evening';
    } else if (hour >= 16 && hour < 19) {
      return 'Good Afternoon';
    } else {
      return 'Good Night';
    }
  }

  void _fetchProfile() async {
    setState(() {
      isProfileFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    // dynamic jwtPayload = await FlutterSessionJwt.getPayload();
    // print(jwtPayload);
    // print(await FlutterSessionJwt.getDurationFromIssuedTime());
    // print(await FlutterSessionJwt.getIssuedDateTime());
    // print(await FlutterSessionJwt.getExpirationDateTime());

    try {
      Response response = await dioClient.get('/auth/me',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        ProfileResponse profileResponse =
            ProfileResponse.fromJson(responseData);
        setState(() {
          profile = profileResponse;
          isProfileFetched = false;
        });

        // Now you can use profileResponse
        print('Profile ID: ${profileResponse.id}');
        print('Profile Name: ${profileResponse.name}');
        print('Profile Email: ${profileResponse.email}');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch profile data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      setState(() {
        isProfileFetched = false;
      });
      if (e.response != null && e.response?.statusCode != 429) {
        // ignore: use_build_context_synchronously
        toastification.show(
            context: context,
            title: Text(e.response?.data['message']),
            autoCloseDuration: const Duration(seconds: 3),
            type: ToastificationType.warning,
            style: ToastificationStyle.flatColored,
            alignment: Alignment.topCenter,
            direction: TextDirection.ltr,
            dragToClose: true,
            showProgressBar: false);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // ignore: use_build_context_synchronously
        toastification.show(
            context: context,
            title: e.message != null
                ? Text(e.response!.statusMessage!)
                : const Text("Server Error"),
            description: const Text(
              'Please try again later',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            autoCloseDuration: const Duration(seconds: 3),
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
            alignment: Alignment.topCenter,
            direction: TextDirection.ltr,
            dragToClose: true,
            showProgressBar: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Profile Navbar
          Skeletonizer(
              enabled: isProfileFetched,
              child: Row(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  greeting,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  profile.name!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Skeleton.keep(
                    child: Column(
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
                                          const Notifications()));
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
                  )
                ],
              )),

          // Home Banners
          Skeletonizer(
            enabled: isBannerFetched,
            child: homeSlider,
          ),

          // Categories
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
          Skeletonizer(
            enabled: isCategoriesFetched,
            child: homeCommunityCategories(context),
          ),

          // Events
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
          Skeletonizer(
            enabled: isEventsFetched,
            ignoreContainers: true,
            child: const SizedBox(
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
