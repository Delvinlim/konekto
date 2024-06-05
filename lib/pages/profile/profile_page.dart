import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/models/community_posts_response.dart';
import 'package:konekto/models/profile_response.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/utils/konekto_profile_modal.dart';
import 'package:konekto/widgets/card/communities_card_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:toastification/toastification.dart';

const _storage = FlutterSecureStorage();

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileResponse profile =
      ProfileResponse(id: '', name: '', username: '', email: '');
  bool isPostsFetched = false;
  List<CommunityPost> postsList = [];
  late ScrollController _scrollController;
  bool _isScrolled = false;
  num totalCommunities = 0;
  num totalLikes = 0;
  num totalPosts = 0;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
    _fetchPosts();
    _fetchMetadata();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 50 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset < 50 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  void _fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userPref = prefs.getString('user');
    print('profile user..');
    print(userPref);
    ProfileResponse profileResponse =
        ProfileResponse.fromJson(json.decode(userPref!));

    setState(() {
      profile = profileResponse;
    });
  }

  void _fetchMetadata() async {
    try {
      dynamic accessToken = await _storage.read(key: 'jwtToken');
      print('runngin');
      Response res = await dioClient.get('/me/metadata/${profile.id}',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      final response = json.decode(res.toString());

      print('metaa data user');
      print(response);

      setState(() {
        totalLikes = response['data']['totalLikes']['count'] ?? 0;
        totalPosts = response['data']['totalPosts']['count'] ?? 0;
        totalCommunities = response['data']['totalCommunities']['count'] ?? 0;
      });
    } catch (e) {}
  }

  void _fetchPosts() async {
    setState(() {
      isPostsFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.get(
          '/community/posts/me/${profile.id}',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print('hello here..');
      print(response);
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        CommunityPostsResponse communityPostsResponse =
            CommunityPostsResponse.fromJson(responseData);
        print('here.');
        print(responseData);
        // PostResponse communityPostsResponse =
        //     PostResponse.fromJson(responseData);
        setState(() {
          postsList = communityPostsResponse.communityPosts ?? [];
          isPostsFetched = false;
        });
        // Successful response, parse the JSON
        print('posts...');
        // print(communityPostsResponse.communityPosts?.partnerDetail);
        print(communityPostsResponse.communityPosts);
        print('end post response');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch posts data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('error post disini.......');
      print(e);
      setState(() {
        isPostsFetched = false;
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
              'Failed to get posts',
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
      child: ListView(
        controller: _scrollController,

        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StickyHeader(
              header: Container(
                decoration: BoxDecoration(
                  color: CupertinoColors
                      .white, // Set your desired background color here
                  boxShadow: _isScrolled
                      ? [
                          BoxShadow(
                            color: CupertinoColors.black.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
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
                            Column(
                              children: [
                                Container(
                                  width: 84,
                                  height: 42,
                                  margin: const EdgeInsets.only(
                                      top: 30, bottom: 10),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 18,
                                        child: Container(
                                          width: 84,
                                          height: 24,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                width: 1,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                                color: Color(0xFFE2E2E2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '@${profile.username!}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
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
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Text(
                                          profile.name!,
                                          style: const TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    // Hamburger Menu
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 10, right: 10, bottom: 10),
                              child: CupertinoButton(
                                onPressed: () {
                                  showCupertinoModalBottomSheet(
                                      expand: false,
                                      context: context,
                                      builder: (context) =>
                                          const ProfileModal());
                                  // Navigator.push(
                                  //     context,
                                  //     CupertinoPageRoute(
                                  //         builder: (context) =>
                                  //             const NotificationsPage()));rr
                                },
                                child: const Icon(
                                  CupertinoIcons.bars,
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
              ),
              content: Column(
                children: [
                  SizedBox(
                    width: 296,
                    height: 62,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 296,
                            height: 62,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF6F6F6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 29,
                          top: 34,
                          child: Text(
                            'Communities',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 213,
                          top: 34,
                          child: Text(
                            'Likes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 129,
                          top: 34,
                          child: Text(
                            'Posts',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 13,
                          child: Text(
                            totalCommunities.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 214,
                          top: 13,
                          child: Text(
                            totalLikes.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 138,
                          top: 13,
                          child: Text(
                            totalPosts.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text("Bio",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  Container(
                    width: 296,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0xFFD2D2D2),
                        ),
                      ),
                    ),
                  ),
                  Skeletonizer(
                      enabled: isPostsFetched,
                      child: isPostsFetched
                          ? SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    const ForYouCommunitiesCard(
                                      communityId: '1',
                                      communityName: 'DTS System',
                                      communityImage:
                                          'https://res.cloudinary.com/dgofpm0tl/image/upload/v1717610913/Konekto/Original_Logo_w0g6bo.png',
                                      content:
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                      contentImage:
                                          'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713103435/Konekto/posts/sdkns2vialkwkcbizgpw.png',
                                      creatorName: 'Delvin Lim',
                                      postId: '1',
                                      isRedirect: true,
                                    ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  for (var post in postsList)
                                    ForYouCommunitiesCard(
                                      communityId: post.communityDetail?.id,
                                      communityName: post.communityDetail?.name,
                                      communityImage:
                                          post.communityDetail?.imageUrl,
                                      content: post.content ??
                                          'content not exist, please contact administrator',
                                      contentImage: post.imageUrl!,
                                      creatorName: post.partnerDetail?.name,
                                      postId: post.id,
                                      isRedirect: true,
                                    ),
                                  if (postsList.isEmpty)
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text('No Post Yet.'),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )),
                ],
              ))
        ],
      ),
    );
  }
}
