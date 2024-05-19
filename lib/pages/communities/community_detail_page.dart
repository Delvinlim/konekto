import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/models/community_posts_response.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../widgets/card/communities_card_widget.dart';

const _storage = FlutterSecureStorage();

class CommunitiesDetailPage extends StatefulWidget {
  const CommunitiesDetailPage(
      {super.key,
      required this.communityId,
      required this.communityName,
      required this.communityImage});
  final String communityId;
  final String communityName;
  final String communityImage;

  @override
  State<CommunitiesDetailPage> createState() => _CommunitiesDetailState();
}

class _CommunitiesDetailState extends State<CommunitiesDetailPage> {
  bool isPostsFetched = false;
  bool isDetailFetched = false;
  List<CommunityPost> postsList = [];
  Map<String, dynamic> communityDetail = {};

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _fetchCommunityDetail();
  }

  void _fetchCommunityDetail() async {
    setState(() {
      isDetailFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.get(
          '/community/detail/${widget.communityId}',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print('hello here community Detail..');
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        setState(() {
          isDetailFetched = false;
          communityDetail = response.data;
        });
        print(communityDetail);
        // Successful response, parse the JSON
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch notification data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('error community detail...');
      print(e);
      setState(() {
        isDetailFetched = false;
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
              'Failed to get communities',
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

  void _fetchPosts() async {
    setState(() {
      isPostsFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.get(
          '/community/posts/${widget.communityId}',
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
              'Failed to get communities',
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
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.communityName),
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.black,
          onPressed: () => {
            Navigator.of(context).pop(context),
          },
        ),
        trailing: GestureDetector(
          onTap: () {
            showCupertinoModalBottomSheet(
                expand: false,
                context: context,
                builder: (context) => const CommunitySettingModal());
          },
          child: const Icon(
            CupertinoIcons.line_horizontal_3,
            color: CupertinoColors.black,
          ),
        ),
      ),
      child: Container(
          color: CupertinoColors.systemGrey6,
          child: ListView(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: const BoxDecoration(color: CupertinoColors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 340,
                            height: 200,
                            child: Stack(
                              children: [
                                Container(
                                  width: 340,
                                  height: 147,
                                  decoration: ShapeDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/community_background.png"),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 128,
                                  top: 105,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 6),
                                    width: 84,
                                    height: 84,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 84,
                                          height: 84,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xFFECEFF1),
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                        Container(
                                          width: 69,
                                          height: 69,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  widget.communityImage),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(232),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.communityName,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: CupertinoColors.black,
                            fontFamily: 'Roboto'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                communityDetail['data']?['total_member']
                                        .toString() ??
                                    'N/A',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: CupertinoColors.black,
                                    fontFamily: 'Roboto'),
                              ),
                              const Text(
                                'Members',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CupertinoColors.black,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                          const Column(
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: CupertinoColors.black,
                                    fontFamily: 'Roboto'),
                              ),
                              Text(
                                'Achievement',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CupertinoColors.black,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                communityDetail['data']?['since'].toString() ??
                                    'N/A',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: CupertinoColors.black,
                                    fontFamily: 'Roboto'),
                              ),
                              const Text(
                                'Since',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CupertinoColors.black,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
              StickyHeader(
                header: Container(
                  decoration: const BoxDecoration(color: CupertinoColors.white),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            'assets/images/profile.png',
                            height: 35.0,
                            width: 35.0,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              color: CupertinoColors.black
                                  .withOpacity(0.4000000059604645),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const CupertinoTextField.borderless(
                          placeholder: 'Write something',
                        ),
                      )),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoButton(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            color: Colors.blue.shade600,
                            child: const Text('Post',
                                style: TextStyle(
                                    fontSize: 16,
                                    // color: CupertinoColors.black,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              print('hello');
                              List<types.User> userUids =
                                  List.empty(growable: true);
                              FirebaseAuth.instance
                                  .authStateChanges()
                                  .listen((User? user) {
                                if (user != null) {
                                  print(user.uid);
                                  userUids.add(types.User(id: user.uid));
                                  // final room = await FirebaseChatCore.instance.createGroupRoom(name: name, users: users)
                                }
                              });

                              // await FirebaseChatCore.instance.room(roomId)
                              final room = await FirebaseChatCore.instance
                                  .createGroupRoom(
                                      name: communityDetail['data']?['name'] ??
                                          'Community Name',
                                      users: userUids);
                              print('check created room');
                              print(room);
                            }),
                      )
                    ],
                  ),
                ),
                content: Skeletonizer(
                    enabled: isPostsFetched,
                    child: isPostsFetched
                        ? Column(
                            children: [
                              for (int i = 0; i < 5; i++)
                                const ForYouCommunitiesCard(
                                  communityId: '1',
                                  communityName: 'DTS System',
                                  communityImage:
                                      'assets/images/communities/odba.png', // TODO Image Url
                                  content:
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                  contentImage:
                                      'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713103435/Konekto/posts/sdkns2vialkwkcbizgpw.png',
                                  creatorName: 'Delvin Lim',
                                  postId: '1',
                                  isRedirect: true,
                                ),
                            ],
                          )
                        : Column(
                            children: [
                              for (var post in postsList)
                                ForYouCommunitiesCard(
                                  communityId: post.communityDetail?.id,
                                  communityName: post.communityDetail?.name,
                                  communityImage:
                                      'assets/images/communities/odba.png', // TODO Image Url
                                  content: post.content,
                                  contentImage: post.imageUrl!,
                                  creatorName: post.partnerDetail?.name,
                                  postId: post.id,
                                  isRedirect: true,
                                ),
                              if (postsList.isEmpty)
                                const SizedBox(
                                  height: 40,
                                ),
                              if (postsList.isEmpty)
                                const Center(
                                  child: Text(
                                    'Empty Post',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                )
                            ],
                          )),
              )
            ],
          )),
    );
  }
}
