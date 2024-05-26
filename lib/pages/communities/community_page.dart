import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/models/communities_response.dart';
import 'package:konekto/models/community_posts_response.dart';
import 'package:konekto/pages/communities/community_list_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/widgets/card/communities_card_widget.dart';
import 'package:konekto/widgets/modals/community_management_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const CommunitiesPage());

enum CommunitiesType { forYou, yourCommunities, discover }

const _storage = FlutterSecureStorage();

class Communities extends StatefulWidget {
  const Communities({super.key});

  @override
  State<Communities> createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities> {
  CommunitiesType _selectedSegment = CommunitiesType.forYou;
  bool isPostsFetched = false;
  bool isCommunitiesFetched = false;

  late List<CommunityPost> postsList = [];
  late List<KonektoCommunity> personalCommunitiesList = [];
  late List<KonektoCommunity> joinedCommunitiesList = [];
  late Map<String, List<KonektoCommunity>> communitiesByCategoriesList = {};

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _fetchCommunities();
    _fetchCommunitiesByCategories();
  }

  void _fetchPosts() async {
    setState(() {
      isPostsFetched = true;
    });
    try {
      Response response = await dioClient.get('/posts');
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        CommunityPostsResponse communityPostsResponse =
            CommunityPostsResponse.fromJson(responseData);
        setState(() {
          postsList = communityPostsResponse.communityPosts ?? [];
          isPostsFetched = false;
        });
        // Successful response, parse the JSON
        print('posts...');
        print(communityPostsResponse.communityPosts);
        print('end post response');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch notification data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error fetch posts...');
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

  void _fetchCommunities() async {
    setState(() {
      isCommunitiesFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.get('/community',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      print('communities list.....');
      print(response.data);
      print(response.data['personalCommunities']);
      print(response.data['joinedCommunities']);
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        PersonalCommunitiesResponse personalCommunitiesResponse =
            PersonalCommunitiesResponse.fromJson(responseData);

        JoinedCommunitiesResponse joinedCommunitiesResponse =
            JoinedCommunitiesResponse.fromJson(responseData);

        setState(() {
          personalCommunitiesList =
              personalCommunitiesResponse.communities ?? [];
          joinedCommunitiesList = joinedCommunitiesResponse.communities ?? [];
          isCommunitiesFetched = false;
        });
        // Successful response, parse the JSON
        print('communities...');
        print(personalCommunitiesResponse.communities);
        print(joinedCommunitiesResponse.communities);
        print('end communities response');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch notification data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error getting community list...');
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

  void _fetchCommunitiesByCategories() async {
    setState(() {
      isCommunitiesFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    try {
      Response response = await dioClient.get('/me/communities',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        CommunitiesResponse communitiesResponse =
            CommunitiesResponse.fromJson(responseData);
        // Access parsed data

        // communitiesResponse.categories.forEach((categoryId, communities) {
        //   print('Category ID: $categoryId');
        //   for (var community in communities) {
        //     print('Community ID: ${community.id}');
        //     print('Community Name: ${community.name}');
        //     print('Since: ${community.since}');
        //   }
        // });
        print('check here important..');
        print(communitiesResponse);
        print(communitiesResponse.categories);
        print(communitiesByCategoriesList);
        setState(() {
          communitiesByCategoriesList = communitiesResponse.categories;
        });
        print(communitiesByCategoriesList);
        // });
        // setState(() {
        //   personalCommunitiesList =
        //       personalCommunitiesResponse.communities ?? [];
        //   joinedCommunitiesList = joinedCommunitiesResponse.communities ?? [];
        //   isCommunitiesFetched = false;
        // });
        // // Successful response, parse the JSON
        // print('communities...');
        // print(personalCommunitiesResponse.communities);
        // print(joinedCommunitiesResponse.communities);
        // print('end communities response');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch communities data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error communities by categories...');
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
        backgroundColor: CupertinoColors.white,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 30, left: 10, right: 10),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Communities',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 30, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                showCupertinoModalBottomSheet(
                                    expand: false,
                                    context: context,
                                    builder: (context) =>
                                        CommunityManagementModal(
                                          personalCommunities:
                                              personalCommunitiesList,
                                          joinedCommunities:
                                              joinedCommunitiesList,
                                        ));
                              },
                              child: const Icon(
                                CupertinoIcons.plus,
                                color: CupertinoColors.black,
                                size: 32,
                              ),
                            )),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 30),
                        //   child: CupertinoButton(
                        //     onPressed: () {
                        //       Navigator.of(context).push(CupertinoPageRoute(
                        //           builder: (context) =>
                        //               const NotificationsPage()));
                        //     },
                        //     child: const Icon(
                        //       CupertinoIcons.search,
                        //       color: CupertinoColors.black,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // Segment Button
            Container(
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                width: double.infinity,
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.10,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CupertinoSlidingSegmentedControl<CommunitiesType>(
                    backgroundColor: CupertinoColors.systemGrey3,
                    thumbColor: Colors.blue.shade600,
                    // This represents the currently selected segmented control.
                    groupValue: _selectedSegment,
                    // Callback that sets the selected segmented control.
                    onValueChanged: (CommunitiesType? value) {
                      if (value != null) {
                        setState(() {
                          _selectedSegment = value;
                        });
                      }
                    },
                    children: const <CommunitiesType, Widget>{
                      CommunitiesType.forYou: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'For You',
                          style: TextStyle(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      CommunitiesType.yourCommunities: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Your Coms',
                          style: TextStyle(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      CommunitiesType.discover: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Discover',
                          style: TextStyle(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    },
                  ),
                )),
            if (_selectedSegment.name == 'forYou') ...[
              Expanded(
                  child: Container(
                      color: CupertinoColors.systemGrey6,
                      // color: const Color(0xFF00FF00),
                      child: Skeletonizer(
                        enabled: isPostsFetched,
                        child: isPostsFetched
                            ? ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    const ForYouCommunitiesCard(
                                      communityId: '1',
                                      communityName: 'DTS System',
                                      communityImage:
                                          'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713084301/Konekto/vcmizhfbdgj8xblpcead.png',
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
                            : ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                children: [
                                  for (var post in postsList)
                                    ForYouCommunitiesCard(
                                      communityId: post.communityDetail?.id,
                                      communityName: post.communityDetail?.name,
                                      communityImage: post
                                              .communityDetail?.imageUrl ??
                                          'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713084301/Konekto/vcmizhfbdgj8xblpcead.png',
                                      content: post.content ??
                                          'content not exist, please contact administrator',
                                      contentImage: post.imageUrl!,
                                      creatorName: post.partnerDetail?.name,
                                      postId: post.id,
                                      isRedirect: true,
                                    ),
                                ],
                              ),
                      ))),
            ] else if (_selectedSegment.name == 'yourCommunities') ...[
              Expanded(
                  child: SizedBox(
                // color: const Color(0xFF00FF00),
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Text(
                        'Your Communities',
                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    for (var community in personalCommunitiesList)
                      CommunitiesCard(
                        communityId: community.id,
                        communityName: community.name,
                        communityImage: community.imageUrl ??
                            'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713084301/Konekto/vcmizhfbdgj8xblpcead.png',
                        communitySince: community.since,
                      ),
                    // CommunitiesCard(
                    //   communityName: 'Buaran',
                    //   communityImage: 'assets/images/communities/buaran.png',
                    // ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Text(
                        'Joined',
                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    for (var community in joinedCommunitiesList)
                      CommunitiesCard(
                        communityId: community.id,
                        communityName: community.name,
                        communityImage: community.imageUrl ??
                            'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713084301/Konekto/vcmizhfbdgj8xblpcead.png',
                        communitySince: community.since,
                      ),
                    // const CommunitiesCard(
                    //   communityName: "Devil's Rejected Nation",
                    //   communityImage: 'assets/images/communities/dnr.png',
                    // ),
                    // const CommunitiesCard(
                    //   communityName: 'NorthArm',
                    //   communityImage: 'assets/images/communities/northarm.png',
                    // ),
                    // const CommunitiesCard(
                    //   communityName: 'Spartans',
                    //   communityImage: 'assets/images/communities/spartans.png',
                    // ),
                    // const CommunitiesCard(
                    //   communityName: 'Rasson',
                    //   communityImage: 'assets/images/communities/rasson.png',
                    // ),
                    // const CommunitiesCard(
                    //   communityName: 'Sydney Real',
                    //   communityImage:
                    //       'assets/images/communities/sydney_real.png',
                    // ),
                    // const CommunitiesCard(
                    //   communityName: 'Super Slasher Aquatics',
                    //   communityImage:
                    //       'assets/images/communities/super_slasher_aquatics.png',
                    // ),
                  ],
                ),
              )),
            ] else ...[
              Expanded(
                  child: SizedBox(
                // color: const Color(0xFF00FF00),
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    for (var category in communitiesByCategoriesList.entries)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 5, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(category.key,
                                    style: const TextStyle(
                                      color: CupertinoColors.black,
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                CommunitiesList(
                                                  categoryId: category.key,
                                                  categoryName: 'General',
                                                )));
                                  },
                                  child: const Text(
                                    'See All',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  for (var community in category.value)
                                    DiscoverCommunitiesCard(
                                      communitiesId: community.id!,
                                      communitiesImage: community.imageUrl ??
                                          'https://res.cloudinary.com/dgofpm0tl/image/upload/v1713084301/Konekto/vcmizhfbdgj8xblpcead.png',
                                      communitiesName: community.name!,
                                    ),
                                ]),
                          )
                        ],
                      )
                  ],
                ),
              )),
            ],
          ],
        ));
  }
}
