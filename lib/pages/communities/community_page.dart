import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/models/community_posts_response.dart';
import 'package:konekto/pages/communities/community_list_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/widgets/card/communities_card_widget.dart';
import 'package:konekto/widgets/modals/community_management_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toastification/toastification.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const CommunitiesPage());

enum CommunitiesType { forYou, yourCommunities, discover }

class Communities extends StatefulWidget {
  const Communities({super.key});

  @override
  State<Communities> createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities> {
  CommunitiesType _selectedSegment = CommunitiesType.forYou;
  bool isPostsFetched = false;

  late List<CommunityPost> postsList = [];

  @override
  void initState() {
    super.initState();
    print('commnity page');
    _fetchPosts();
  }

  void _fetchPosts() async {
    setState(() {
      isPostsFetched = true;
    });
    try {
      Response response = await dioClient.get('/posts');
      print('check.....');
      print(response);
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
      print('error post...');
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
                                        const CommunityManagementModal());
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
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  children: [
                    for (var post in postsList)
                      ForYouCommunitiesCard(
                        communityName: post.communityDetail?.name,
                        communityImage:
                            'assets/images/communities/odba.png', // TODO Image Url
                        content: post.content,
                        contentImage: post.imageUrl!,
                        creatorName: post.partnerDetail?.name,
                        isRedirect: true,
                      ),
                  ],
                ),
              )),
            ] else if (_selectedSegment.name == 'yourCommunities') ...[
              Expanded(
                  child: SizedBox(
                // color: const Color(0xFF00FF00),
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: const [
                    Padding(
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
                    CommunitiesCard(
                      communityName: 'ODBA',
                      communityImage: 'assets/images/communities/odba.png',
                    ),
                    CommunitiesCard(
                      communityName: 'Buaran',
                      communityImage: 'assets/images/communities/buaran.png',
                    ),
                    Padding(
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
                    CommunitiesCard(
                      communityName: 'PSEG Fossil',
                      communityImage:
                          'assets/images/communities/pseg_fossil.png',
                    ),
                    CommunitiesCard(
                      communityName: "Devil's Rejected Nation",
                      communityImage: 'assets/images/communities/dnr.png',
                    ),
                    CommunitiesCard(
                      communityName: 'NorthArm',
                      communityImage: 'assets/images/communities/northarm.png',
                    ),
                    CommunitiesCard(
                      communityName: 'Spartans',
                      communityImage: 'assets/images/communities/spartans.png',
                    ),
                    CommunitiesCard(
                      communityName: 'Rasson',
                      communityImage: 'assets/images/communities/rasson.png',
                    ),
                    CommunitiesCard(
                      communityName: 'Sydney Real',
                      communityImage:
                          'assets/images/communities/sydney_real.png',
                    ),
                    CommunitiesCard(
                      communityName: 'Super Slasher Aquatics',
                      communityImage:
                          'assets/images/communities/super_slasher_aquatics.png',
                    ),
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('General',
                                          style: TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ))
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
                                                  const CommunitiesList(
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/deagleders.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/inter.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/rasson.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/northarm.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/aldenaire.png',
                            ),
                          ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Motorcycle',
                                          style: TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ))
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
                                                  const CommunitiesList(
                                                    categoryName: 'Motorcycle',
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/dnr.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/punishers.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/merciless.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/berserkers.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/ratled.png',
                            ),
                          ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Basketball',
                                          style: TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ))
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
                                                  const CommunitiesList(
                                                    categoryName: 'Basketball',
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/elite.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/surry_hills.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/borcelle.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/bellerive.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/hanover.png',
                            ),
                          ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Badminton',
                                          style: TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ))
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
                                                  const CommunitiesList(
                                                    categoryName: 'Badminton',
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/friends_united.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/giants_of_manchester.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/shuttle_whackers.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/badminton_warriors.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/team_troubles.png',
                            ),
                          ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Volleyball',
                                          style: TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ))
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
                                                  const CommunitiesList(
                                                    categoryName: 'Volleyball',
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/hardhitters.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/phoenix_volleyball.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/volley_kings.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/spikes_volleyball.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/spread_eagles.png',
                            ),
                          ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Games',
                                          style: TextStyle(
                                            color: CupertinoColors.black,
                                            fontSize: 18,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w700,
                                          ))
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
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  const CommunitiesList(
                                                    categoryName: 'Games',
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/stryker_gaming.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/titans.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/martians.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/the_last_frontier.png',
                            ),
                            DiscoverCommunitiesCard(
                              communitiesImage:
                                  'assets/images/communities/kraken.png',
                            ),
                          ]),
                    ),
                  ],
                ),
              )),
            ],
          ],
        ));
  }
}
