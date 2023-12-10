import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/auth/forget_password_page.dart';
import 'package:konekto/pages/notifications/notification_page.dart';
import 'package:konekto/widgets/card/communities_card_widget.dart';
import 'package:konekto/widgets/modals/community_management_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const CommunitiesPage());

enum CommunitiesType { forYou, yourCommunities, discover }

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Communities(),
    );
  }
}

class Communities extends StatefulWidget {
  const Communities({super.key});

  @override
  State<Communities> createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities> {
  CommunitiesType _selectedSegment = CommunitiesType.forYou;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        // navigationBar: const CupertinoNavigationBar(
        //   middle: Text('Communities'),
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
                            padding: const EdgeInsets.only(top: 30),
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
                                color: Colors.black,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: CupertinoButton(
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) =>
                                      const NotificationsPage()));
                            },
                            child: const Icon(
                              CupertinoIcons.search,
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
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                      CommunitiesType.yourCommunities: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Your Coms',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                      CommunitiesType.discover: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Discover',
                          style: TextStyle(color: CupertinoColors.white),
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
                  children: const [
                    ForYouCommunitiesCard(
                      communityName: 'ODBA',
                      isRedirect: true,
                    ),
                    ForYouCommunitiesCard(
                      communityName: 'Buaran',
                      isRedirect: true,
                    ),
                    ForYouCommunitiesCard(
                      communityName: 'PSEG Fossil',
                      isRedirect: true,
                    ),
                    ForYouCommunitiesCard(
                      communityName: 'NorthArm',
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
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CommunitiesCard(
                      communityName: 'ODBA',
                    ),
                    CommunitiesCard(
                      communityName: 'Buaran',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Text(
                        'Joined',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CommunitiesCard(
                      communityName: 'PSEG Fossil',
                    ),
                    CommunitiesCard(
                      communityName: "Devil's Rejected Nation",
                    ),
                    CommunitiesCard(
                      communityName: 'NorthArm',
                    ),
                    CommunitiesCard(
                      communityName: 'Spartans',
                    ),
                    CommunitiesCard(
                      communityName: 'Rasson',
                    ),
                    CommunitiesCard(
                      communityName: 'Sydney Real',
                    ),
                    CommunitiesCard(
                      communityName: 'Super',
                    ),
                    CommunitiesCard(
                      communityName: 'ODBA',
                    ),
                    CommunitiesCard(
                      communityName: 'ODBA',
                    ),
                    CommunitiesCard(
                      communityName: 'ODBA',
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
                                            color: Colors.black,
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
                                                  const ForgetPasswordPage()));
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
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
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
                                            color: Colors.black,
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
                                                  const ForgetPasswordPage()));
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
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
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
                                            color: Colors.black,
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
                                                  const ForgetPasswordPage()));
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
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
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
                                            color: Colors.black,
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
                                                  const ForgetPasswordPage()));
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
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
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
                                            color: Colors.black,
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
                                                  const ForgetPasswordPage()));
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
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
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
                                      Text('Anime',
                                          style: TextStyle(
                                            color: Colors.black,
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
                                                  const ForgetPasswordPage()));
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
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
                            DiscoverCommunitiesCard(),
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
