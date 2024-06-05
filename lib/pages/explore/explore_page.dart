import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/pages/communities/community_detail_page.dart';
import 'package:konekto/pages/explore/explore_result_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

import '../../widgets/card/location_card_widget.dart';

const _storage = FlutterSecureStorage();

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final FocusNode _searchFocusNode = FocusNode();
  // TextEditingController textController;
  var textController = TextEditingController(text: '');
  bool isPlacesFetched = false;
  bool isCommunitiesFetched = false;
  List<dynamic> placesList = [{}];
  List<dynamic> communitiesList = [{}];

  @override
  void initState() {
    super.initState();
    _fetchPlaces();
    _fetchCommunities();
  }

  @override
  void dispose() {
    textController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _fetchCommunities() async {
    setState(() {
      isCommunitiesFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.get('/me/top-communities',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print('hello here..');
      print(response);
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        // Map<String, dynamic> responseData = response.data;
        // CommunityPostsResponse communityPostsResponse =
        //     CommunityPostsResponse.fromJson(responseData);
        print('here.........');
        print(response.data);
        // print(responseData);
        // PostResponse communityPostsResponse =
        //     PostResponse.fromJson(responseData);
        setState(() {
          communitiesList = response.data['data'] ?? [];
          isCommunitiesFetched = false;
        });
        // Successful response, parse the JSON
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch communities data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('error communities disini.......');
      print(e);
      setState(() {
        isCommunitiesFetched = false;
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
              'Failed to get events',
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

  void _fetchPlaces() async {
    setState(() {
      isPlacesFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.get('/recommended-places');
      print('hello here..');
      print(response);
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        // Map<String, dynamic> responseData = response.data;
        // CommunityPostsResponse communityPostsResponse =
        //     CommunityPostsResponse.fromJson(responseData);
        print('here.');
        print(response.data);
        // print(responseData);
        // PostResponse communityPostsResponse =
        //     PostResponse.fromJson(responseData);
        setState(() {
          placesList = response.data['data'] ?? [];
          isPlacesFetched = false;
        });
        // Successful response, parse the JSON
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch posts data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('error event disini.......');
      print(e);
      setState(() {
        isPlacesFetched = false;
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
              'Failed to get events',
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
            child: CupertinoSearchTextField(
              controller: textController,
              placeholder: 'Search communities',
              focusNode: _searchFocusNode,
              onTap: () {
                // Navigate to the blank page on search submit
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ExploreResult(),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                              'Top Communities',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
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
            enabled: isCommunitiesFetched,
            child: isCommunitiesFetched
                ? Column(children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    'assets/images/communities/dnr.png',
                                    height: 35.0,
                                    width: 35.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Devils Rejected Nation',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        '105 Members',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // Text(
                                      //   'Joined',
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //     color: CupertinoColors.black,
                                      //     fontSize: 10,
                                      //     fontFamily: 'Inter',
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 12, vertical: 6),
                              //     decoration: ShapeDecoration(
                              //       color: const Color(0xFF0689FF),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(20),
                              //       ),
                              //     ),
                              //     child: const Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       children: [
                              //         Text(
                              //           'Message',
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 12,
                              //             fontFamily: 'Roboto',
                              //             fontWeight: FontWeight.w500,
                              //             letterSpacing: 0.50,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    'assets/images/communities/inter.png',
                                    height: 35.0,
                                    width: 35.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Inter',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        '24 Members',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // Text(
                                      //   'Joined',
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //     color: CupertinoColors.black,
                                      //     fontSize: 10,
                                      //     fontFamily: 'Roboto',
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 12, vertical: 6),
                              //   decoration: ShapeDecoration(
                              //     color: const Color(0xFF0689FF),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20),
                              //     ),
                              //   ),
                              //   child: const Row(
                              //     mainAxisSize: MainAxisSize.min,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         'Message',
                              //         style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 12,
                              //           fontFamily: 'Roboto',
                              //           fontWeight: FontWeight.w500,
                              //           letterSpacing: 0.50,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    'assets/images/communities/spartans.png',
                                    height: 35.0,
                                    width: 35.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Spartans',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        '24 Members',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // Text(
                                      //   'Joined',
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //     color: CupertinoColors.black,
                                      //     fontSize: 10,
                                      //     fontFamily: 'Inter',
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 12, vertical: 6),
                              //   decoration: ShapeDecoration(
                              //     color: const Color(0xFF0689FF),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20),
                              //     ),
                              //   ),
                              //   child: const Row(
                              //     mainAxisSize: MainAxisSize.min,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         'Join',
                              //         style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 12,
                              //           fontFamily: 'Roboto',
                              //           fontWeight: FontWeight.w500,
                              //           letterSpacing: 0.50,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    'assets/images/communities/rasson.png',
                                    height: 35.0,
                                    width: 35.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rasson',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 12, vertical: 6),
                              //   decoration: ShapeDecoration(
                              //     color: const Color(0xFFF6F6F6),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20),
                              //     ),
                              //   ),
                              //   child: const Row(
                              //     mainAxisSize: MainAxisSize.min,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         'Requested',
                              //         style: TextStyle(
                              //           color: CupertinoColors.black,
                              //           fontSize: 12,
                              //           fontFamily: 'Roboto',
                              //           fontWeight: FontWeight.w500,
                              //           letterSpacing: 0.50,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    'assets/images/communities/northarm.png',
                                    height: 35.0,
                                    width: 35.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'NorthArm',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        '15 Members',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 12, vertical: 6),
                              //   decoration: ShapeDecoration(
                              //     color: const Color(0xFF0689FF),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20),
                              //     ),
                              //   ),
                              //   child: const Row(
                              //     mainAxisSize: MainAxisSize.min,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         'Message',
                              //         style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 12,
                              //           fontFamily: 'Roboto',
                              //           fontWeight: FontWeight.w500,
                              //           letterSpacing: 0.50,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ])
                : Column(children: [
                    for (var community in communitiesList)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.network(
                                      community['imageUrl'] ??
                                          'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png',
                                      height: 35.0,
                                      width: 35.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          community['name'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          community['since'].toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        // Text(
                                        //   'Joined',
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(
                                        //     color: CupertinoColors.black,
                                        //     fontSize: 10,
                                        //     fontFamily: 'Inter',
                                        //     fontWeight: FontWeight.w400,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                CommunitiesDetailPage(
                                                  communityId: community['id']
                                                      .toString(),
                                                  communityName:
                                                      community['name'],
                                                  communityImage: community?[
                                                          'imageUrl'] ??
                                                      'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png',
                                                  isJoined: false,
                                                )));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF0689FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Detail',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                  ]),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                              'Place you should visit',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
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
            enabled: isPlacesFetched,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: isPlacesFetched
                  ? const Row(
                      children: [
                        LocationCard(
                          placeId: '1',
                          placeImage:
                              'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713033187/Konekto/events/gomoo8js1ectudaci8rr.png',
                          placeName: 'Default Place',
                        ),
                        LocationCard(
                          placeId: '1',
                          placeImage:
                              'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713033187/Konekto/events/gomoo8js1ectudaci8rr.png',
                          placeName: 'Default Place',
                        ),
                        LocationCard(
                          placeId: '1',
                          placeImage:
                              'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713033187/Konekto/events/gomoo8js1ectudaci8rr.png',
                          placeName: 'Default Place',
                        ),
                        LocationCard(
                          placeId: '1',
                          placeImage:
                              'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713033187/Konekto/events/gomoo8js1ectudaci8rr.png',
                          placeName: 'Default Place',
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        for (var place in placesList)
                          LocationCard(
                            placeId: place['id']?.toString() ?? '1',
                            placeImage: place['imageUrl'] ??
                                'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713033187/Konekto/events/gomoo8js1ectudaci8rr.png',
                            placeName: place['name'] ?? 'Default Place',
                          ),
                        // LocationCard(
                        //   placeName: "Orchid Badminton Hall",
                        //   placeImage: "assets/images/events/orchid_hall.png",
                        // ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
