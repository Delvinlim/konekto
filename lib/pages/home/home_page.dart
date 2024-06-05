import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:konekto/models/community_categories_response.dart';
import 'package:konekto/models/community_events_response.dart';
import 'package:konekto/models/profile_response.dart';
import 'package:konekto/pages/communities/community_list_page.dart';
import 'package:konekto/pages/notifications/notification_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:konekto/widgets/card/event_card_widget.dart';
import 'package:konekto/widgets/modals/category_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        theme: const CupertinoThemeData(brightness: Brightness.light),
        home: const Home(),
        builder: EasyLoading.init());
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

final List tempImageList = [
  'assets/images/banner_1.png',
  'assets/images/banner_2.png',
  'assets/images/banner_3.png',
];

Widget homeCommunityCategories(context) {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Bone.square(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  size: 20,
                )),
            Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Bone.square(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  size: 20,
                )),
            Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Bone.square(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  size: 20,
                )),
            Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Bone.square(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  size: 20,
                )),
            Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Bone.square(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  size: 20,
                )),
          ]));
}

class _HomeState extends State<Home> {
  // Skeletonizer Init
  bool isProfileFetched = false;
  bool isBannerFetched = false;
  bool isCategoriesFetched = false;
  bool isEventsFetched = false;

  // API Values
  ProfileResponse profile =
      ProfileResponse(id: '', name: '', username: '', email: '');
  // late CommunityCategoriesResponse communityCategories =
  //     CommunityCategoriesResponse(id: '', name: '', imageUrl: '');
  late String greeting;
  late bool isUnreadNotification = true;
  late List imageUrlList = [];
  late List<CommunityCategory> communityCategoriesList = [];
  late List<CommunityEvent> communityEventsList = [];

  @override
  void initState() {
    super.initState();
    _fetchProfile();
    _getUnreadNotification();
    _fetchBanners();
    _fetchCommunityCategories();
    _fetchCommunityEvents();
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

  void _getUnreadNotification() async {
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response res = await dioClient.get('/me/notifications?unread=1',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      final response = json.decode(res.toString());
      if (res.statusCode == 200) {
        // Successful response, parse the JSON
        setState(() {
          isUnreadNotification = response['isUnread'];
        });
        print('notification...');
        print(response);
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch notification data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response?.data['message'] != null &&
          e.response?.statusCode != 429) {
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
        // ignore: use_build_context_synchronously
        toastification.show(
            context: context,
            title: e.message != null
                ? Text(e.response!.statusMessage!)
                : const Text("Server Error"),
            description: const Text(
              'Failed to get unread notifications',
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

  void _fetchProfile() async {
    setState(() {
      isProfileFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    dynamic jwtPayload = await FlutterSessionJwt.getPayload();
    print('jwt payload');
    print(jwtPayload);
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

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', json.encode(profileResponse));

        // Now you can use profileResponse
        print('Profile ID: ${profileResponse.id}');
        print('Profile Name: ${profileResponse.name}');
        print('Profile Username: ${profileResponse.username}');
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
      if (e.response?.data['message'] != null &&
          e.response?.statusCode != 429) {
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

  void _fetchBanners() async {
    setState(() {
      isBannerFetched = true;
    });

    try {
      Response res = await dioClient.get('/banners');
      final response = json.decode(res.toString());
      if (res.statusCode == 200) {
        setState(() {
          imageUrlList = response['data'];
          isBannerFetched = false;
        });
      }
      print('banner reponse');
      print(response);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      setState(() {
        isBannerFetched = false;
      });
      if (e.response?.data['message'] != null &&
          e.response?.statusCode != 429) {
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

  void _fetchCommunityCategories() async {
    setState(() {
      isCategoriesFetched = true;
    });

    try {
      Response response = await dioClient.get('/community/categories?limit=8');
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        CommunityCategoriesResponse communityCategoriesResponse =
            CommunityCategoriesResponse.fromJson(responseData);
        print('community categories response');
        print(responseData);
        setState(() {
          communityCategoriesList =
              communityCategoriesResponse.categories ?? [];
          isCategoriesFetched = false;
        });
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      setState(() {
        isCategoriesFetched = false;
      });
      if (e.response?.data['message'] != null &&
          e.response?.statusCode != 429) {
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

  void _fetchCommunityEvents() async {
    setState(() {
      isEventsFetched = true;
    });

    try {
      Response response = await dioClient.get('/community/events');
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        CommunityEventsResponse communityEventsResponse =
            CommunityEventsResponse.fromJson(responseData);
        print('community events response');
        print(responseData);
        setState(() {
          communityEventsList = communityEventsResponse.events ?? [];
          isEventsFetched = false;
        });
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      setState(() {
        isEventsFetched = false;
      });
      if (e.response?.data['message'] != null &&
          e.response?.statusCode != 429) {
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
                              child: Image.network(
                                'https://i.pravatar.cc/300',
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
                                          const Notifications()));
                                },
                                child: Stack(
                                  alignment: const Alignment(1, -1),
                                  children: [
                                    const Icon(
                                      CupertinoIcons.bell,
                                      color: CupertinoColors.black,
                                    ),
                                    if (isUnreadNotification) // Conditionally render based on isUnreadNotification
                                      const Icon(
                                        CupertinoIcons.circle_fill,
                                        color: CupertinoColors.systemRed,
                                        size: 12,
                                      ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),

          // Home Banners
          Skeletonizer(
            enabled: isBannerFetched,
            child: SizedBox(
              height: 200,
              child: isBannerFetched
                  ? Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        // Ideal size 320 x 200 or 16:9 image
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            tempImageList[index],
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
                    )
                  : Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        // Ideal size 320 x 200 or 16:9 image
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            imageUrlList[index],
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: CupertinoColors.black,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                          // child: Image.asset(
                          //   imageUrlList[index],
                          //   fit: BoxFit.fill,
                          // ),
                        );
                      },
                      itemCount: imageUrlList.length,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      autoplay: true,
                      pagination: const SwiperPagination(),
                      // control: const SwiperControl(),
                    ),
            ),
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
            child: isCategoriesFetched
                ? homeCommunityCategories(context) // Fake Data
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (var category in communityCategoriesList)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => CommunitiesList(
                                              categoryId: category.id!,
                                              categoryName: category.name!,
                                            )));
                              },
                              child: Container(
                                width: 64,
                                height: 64,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    border: KonektoBorder.all(
                                        color: Colors.grey.shade400),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                    color: const Color(0xffD9D9D9)),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(50.0),
                                  // TODO Default network image
                                  child: Image.network(
                                    category.imageUrl ?? '',
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                ),
                              ),
                            ),
                        ])),
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
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: isEventsFetched
                    ? Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Container(
                                width: 180,
                                height: 180,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      width: 200,
                                      height: 85,
                                      child: Bone.square(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        size: 1,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 12, bottom: 8),
                                      child: const Text(
                                        'Title goes here',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 150,
                                      height: 30,
                                      child: Bone.square(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                )),
                        ],
                      )
                    : Row(
                        children: [
                          for (var event in communityEventsList)
                            EventCard(
                              eventId: event.id!,
                              eventName: event.name!,
                              eventImage: event.imageUrl!,
                            ),
                          // EventCard(
                          //   eventName: 'Batam Drawing',
                          //   eventImage: 'assets/images/events/batam_drawing.png',
                          // ),
                          // EventCard(
                          //   eventName: 'UIB Run',
                          //   eventImage: 'assets/images/events/ika_uib.png',
                          // ),
                        ],
                      ),
              ),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         children: [
          //           Row(
          //             children: [
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     'Favorites',
          //                     style: TextStyle(
          //                         fontSize: 18, fontWeight: FontWeight.bold),
          //                   )
          //                 ],
          //               )
          //             ],
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // homeCommunityCategories(context),
        ],
      ),
    ));
  }
}
