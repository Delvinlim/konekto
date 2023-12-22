import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../widgets/card/communities_card_widget.dart';

class CommunitiesDetailPage extends StatefulWidget {
  const CommunitiesDetailPage(
      {super.key, required this.communityName, required this.communityImage});
  final String communityName;
  final String communityImage;

  @override
  State<CommunitiesDetailPage> createState() => _CommunitiesDetailState();
}

class _CommunitiesDetailState extends State<CommunitiesDetailPage> {
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
            // Navigator.pushAndRemoveUntil(context,
            //     CupertinoPageRoute(builder: (BuildContext context) {
            //   return const CommunitiesPage();
            // }), (r) {
            //   return false;
            // })
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                '66',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: CupertinoColors.black,
                                    fontFamily: 'Roboto'),
                              ),
                              Text(
                                'Members',
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
                                '13',
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
                                '2019',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: CupertinoColors.black,
                                    fontFamily: 'Roboto'),
                              ),
                              Text(
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
                    decoration:
                        const BoxDecoration(color: CupertinoColors.white),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
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
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              color: Colors.blue.shade600,
                              child: const Text('Post',
                                  style: TextStyle(
                                      fontSize: 16,
                                      // color: CupertinoColors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {}),
                        )
                      ],
                    ),
                  ),
                  content: Column(
                    children: [
                      ForYouCommunitiesCard(
                        communityName: widget.communityName,
                        communityImage: widget.communityImage,
                        creatorName: 'Delvin Lim',
                      ),
                      ForYouCommunitiesCard(
                        communityName: widget.communityName,
                        communityImage: widget.communityImage,
                        creatorName: 'Delvin Lim',
                      ),
                      ForYouCommunitiesCard(
                        communityName: widget.communityName,
                        communityImage: widget.communityImage,
                        creatorName: 'Delvin Lim',
                      ),
                      ForYouCommunitiesCard(
                        communityName: widget.communityName,
                        communityImage: widget.communityImage,
                        creatorName: 'Delvin Lim',
                      ),
                    ],
                  )),
              // Container(
              //     padding: const EdgeInsets.symmetric(vertical: 8),
              //     decoration: const BoxDecoration(color: CupertinoColors.white),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             SizedBox(
              //               width: 340,
              //               height: 200,
              //               child: Stack(
              //                 children: [
              //                   Container(
              //                     width: 340,
              //                     height: 147,
              //                     decoration: ShapeDecoration(
              //                       image: const DecorationImage(
              //                         image: NetworkImage(
              //                             "https://via.placeholder.com/340x147"),
              //                         fit: BoxFit.fill,
              //                       ),
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(12),
              //                       ),
              //                     ),
              //                   ),
              //                   Positioned(
              //                     left: 128,
              //                     top: 105,
              //                     child: Container(
              //                       margin: const EdgeInsets.only(right: 6),
              //                       width: 84,
              //                       height: 84,
              //                       child: Stack(
              //                         alignment: Alignment.center,
              //                         children: [
              //                           Container(
              //                             width: 84,
              //                             height: 84,
              //                             decoration: const ShapeDecoration(
              //                               color: Color(0xFFECEFF1),
              //                               shape: OvalBorder(),
              //                             ),
              //                           ),
              //                           Container(
              //                             width: 69,
              //                             height: 69,
              //                             decoration: ShapeDecoration(
              //                               image: const DecorationImage(
              //                                 image: NetworkImage(
              //                                     "https://via.placeholder.com/69x69"),
              //                                 fit: BoxFit.fill,
              //                               ),
              //                               shape: RoundedRectangleBorder(
              //                                 borderRadius:
              //                                     BorderRadius.circular(232),
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //         const Text(
              //           'Community Name',
              //           style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.w700,
              //               color: CupertinoColors.black,
              //               fontFamily: 'Roboto'),
              //         ),
              //         const SizedBox(
              //           height: 10,
              //         ),
              //         const Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             Column(
              //               children: [
              //                 Text(
              //                   '66',
              //                   style: TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w700,
              //                       color: CupertinoColors.black,
              //                       fontFamily: 'Roboto'),
              //                 ),
              //                 Text(
              //                   'Members',
              //                   style: TextStyle(
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                       color: CupertinoColors.black,
              //                       fontFamily: 'Roboto'),
              //                 ),
              //               ],
              //             ),
              //             Column(
              //               children: [
              //                 Text(
              //                   '13',
              //                   style: TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w700,
              //                       color: CupertinoColors.black,
              //                       fontFamily: 'Roboto'),
              //                 ),
              //                 Text(
              //                   'Achievement',
              //                   style: TextStyle(
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                       color: CupertinoColors.black,
              //                       fontFamily: 'Roboto'),
              //                 ),
              //               ],
              //             ),
              //             Column(
              //               children: [
              //                 Text(
              //                   '2019',
              //                   style: TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w700,
              //                       color: CupertinoColors.black,
              //                       fontFamily: 'Roboto'),
              //                 ),
              //                 Text(
              //                   'Since',
              //                   style: TextStyle(
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                       color: CupertinoColors.black,
              //                       fontFamily: 'Roboto'),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         )
              //       ],
              //     )),
              // Container(
              //   decoration: const BoxDecoration(color: CupertinoColors.white),
              //   margin: const EdgeInsets.symmetric(vertical: 12),
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.only(right: 6),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(50.0),
              //           child: Image.asset(
              //             'assets/images/profile.png',
              //             height: 35.0,
              //             width: 35.0,
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //           child: Container(
              //         margin: const EdgeInsets.symmetric(horizontal: 4),
              //         decoration: ShapeDecoration(
              //           color: Colors.white,
              //           shape: RoundedRectangleBorder(
              //             side: BorderSide(
              //               width: 0.50,
              //               color: CupertinoColors.black.withOpacity(0.4000000059604645),
              //             ),
              //             borderRadius: BorderRadius.circular(6),
              //           ),
              //         ),
              //         child: const CupertinoTextField.borderless(
              //           placeholder: 'Write something',
              //         ),
              //       )),
              //       Transform.scale(
              //         scale: 0.8,
              //         child: CupertinoButton(
              //             padding: const EdgeInsets.only(left: 24, right: 24),
              //             color: Colors.blue.shade600,
              //             child: const Text('Post',
              //                 style: TextStyle(
              //                     fontSize: 16,
              //                     // color: CupertinoColors.black,
              //                     fontWeight: FontWeight.bold)),
              //             onPressed: () {}),
              //       )
              //     ],
              //   ),
              // ),
              // ListView(
              //   padding: const EdgeInsets.symmetric(vertical: 8),
              //   children: const [
              //     ForYouCommunitiesCard(),
              //     ForYouCommunitiesCard(),
              //     ForYouCommunitiesCard(),
              //     ForYouCommunitiesCard(),
              //   ],
              // ),
            ],
          )),
    );
  }
}
