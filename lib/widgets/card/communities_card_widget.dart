import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/communities/community_detail_page.dart';
import 'package:konekto/pages/communities/community_post_page.dart';
import 'package:konekto/pages/communities/community_rules_page.dart';
import 'package:konekto/pages/communities/community_settings_page.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

class CommunitiesCard extends StatelessWidget {
  const CommunitiesCard(
      {super.key, required this.communityName, required this.communityImage});
  final String communityName;
  final String communityImage;

  // @override
  // State<CommunitiesCard> createState() => _CommunitiesCardState();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => CommunitiesDetailPage(
                        communityName: communityName,
                        communityImage: communityImage,
                      )));
        },
        child: Row(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    width: 52,
                    height: 52,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFECEFF1),
                            shape: OvalBorder(),
                          ),
                        ),
                        Container(
                          width: 46,
                          height: 46,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage(communityImage),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(232),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          communityName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          'Since 2019',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

// class _CommunitiesCardState extends State<CommunitiesCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 130,
//           height: 60,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 52,
//                 height: 52,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       left: 0,
//                       top: 0,
//                       child: Container(
//                         width: 52,
//                         height: 52,
//                         decoration: const ShapeDecoration(
//                           color: Color(0xFFECEFF1),
//                           shape: OvalBorder(),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       child: SizedBox(
//                         width: 46,
//                         height: 46,
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               child: Container(
//                                 width: 46,
//                                 height: 46,
//                                 decoration: ShapeDecoration(
//                                   image: const DecorationImage(
//                                     image: NetworkImage(
//                                         "https://via.placeholder.com/46x46"),
//                                     fit: BoxFit.fill,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(232),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Container(
//                 clipBehavior: Clip.antiAlias,
//                 decoration: const BoxDecoration(),
//                 child: const Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'ODBA',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: CupertinoColors.black,
//                         fontSize: 16,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Text(
//                       'Since 2019',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: CupertinoColors.black,
//                         fontSize: 12,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class ForYouCommunitiesCard extends StatefulWidget {
  const ForYouCommunitiesCard(
      {super.key,
      required this.communityName,
      required this.communityImage,
      required this.creatorName,
      required this.content,
      required this.contentImage,
      this.isRedirect});
  final String? communityName;
  final String? communityImage;
  final String? creatorName;
  final String? content;
  final String? contentImage;
  final bool? isRedirect;

  @override
  State<ForYouCommunitiesCard> createState() => _ForYouCommunitiesCardState();
}

class _ForYouCommunitiesCardState extends State<ForYouCommunitiesCard> {
  IconData heartIcon = CupertinoIcons.heart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isRedirect == true) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => CommunitiesPost(
                        communityName: widget.communityName!,
                      )));
        }
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset(
                          widget.communityImage!,
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.communityName!,
                          style: const TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.creatorName!,
                          style: const TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Text(
                  'October, 3 2023',
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 10,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            if (widget.contentImage != null && widget.contentImage != '')
              // Container(
              //   height: 300,
              //   decoration: ShapeDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(widget.contentImage!),
              //       fit: BoxFit.fill,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 250,
                child: AspectRatio(
                  aspectRatio: 1.0, // Set aspect ratio to 1:1 (square)
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.contentImage!,
                      fit: BoxFit.cover, // Use BoxFit.cover to fill the square
                      loadingBuilder: (context, widget, loadingProgress) {
                        if (loadingProgress == null) {
                          return widget;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 250,
                            color: CupertinoColors.black,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            // SizedBox(
            //   // Use a LayoutBuilder to get the width of the parent container dynamically
            //   child: LayoutBuilder(
            //     builder: (BuildContext context, BoxConstraints constraints) {
            //       double imageSize = constraints
            //           .maxWidth; // Use the width as the size for both width and height

            //       return Container(
            //         width: imageSize,
            //         height: imageSize,
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: NetworkImage(widget.contentImage!),
            //             fit: BoxFit
            //                 .cover, // Fill the container while maintaining aspect ratio
            //           ),
            //           borderRadius: BorderRadius.circular(4),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // SizedBox(
            //   child: LayoutBuilder(
            //     builder: (BuildContext context, BoxConstraints constraints) {
            //       double imageSize = constraints
            //           .maxWidth; // Use the width as the size for both width and height

            //       return ClipRRect(
            //         borderRadius: BorderRadius.circular(6),
            //         child: Image.network(
            //           widget.contentImage!,
            //           width: imageSize,
            //           height: imageSize,
            //           fit: BoxFit
            //               .cover, // Fill the container while maintaining aspect ratio
            //           loadingBuilder: (context, widget, loadingProgress) {
            //             if (loadingProgress == null) {
            //               return widget;
            //             } else {
            //               return Center(
            //                 child: CircularProgressIndicator(
            //                   value: loadingProgress.expectedTotalBytes !=
            //                           null
            //                       ? loadingProgress.cumulativeBytesLoaded /
            //                           loadingProgress.expectedTotalBytes!
            //                       : null,
            //                 ),
            //               );
            //             }
            //           },
            //           errorBuilder: (context, error, stackTrace) {
            //             return const Center(
            //               child: Icon(
            //                 Icons.broken_image,
            //                 size: 32,
            //                 color: CupertinoColors.black,
            //               ),
            //             );
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),
            if (widget.contentImage != null && widget.contentImage != '')
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    heartIcon == CupertinoIcons.heart_fill
                                        ? heartIcon = CupertinoIcons.heart
                                        : heartIcon = CupertinoIcons.heart_fill;
                                  });
                                },
                                child: Icon(
                                  heartIcon,
                                  color: heartIcon == CupertinoIcons.heart_fill
                                      ? CupertinoColors.systemRed
                                      : CupertinoColors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text(
                                '2,121 likes',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ]),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.chat_bubble_text,
                                  color: CupertinoColors.black,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '298 comments',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('tapped');
                            Share.share('''Hey! check it out\n'''
                                '''Post In: ${widget.communityName}, By: ${widget.creatorName}\n'''
                                '''Says that: ${widget.content}\n''');
                          },
                          child: const Icon(
                            CupertinoIcons.paperplane,
                            color: CupertinoColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      widget.content!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            if (widget.contentImage == null || widget.contentImage == '')
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      widget.content!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    heartIcon == CupertinoIcons.heart_fill
                                        ? heartIcon = CupertinoIcons.heart
                                        : heartIcon = CupertinoIcons.heart_fill;
                                  });
                                },
                                child: Icon(
                                  heartIcon,
                                  color: heartIcon == CupertinoIcons.heart_fill
                                      ? CupertinoColors.systemRed
                                      : CupertinoColors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text(
                                '2,121 likes',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ]),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.chat_bubble_text,
                                  color: CupertinoColors.black,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '258 comments',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('tapped');
                            Share.share('''Hey! check it out\n'''
                                '''Post In: ${widget.communityName}, By: ${widget.creatorName}\n'''
                                '''Says that: ${widget.content}\n''');
                          },
                          child: const Icon(
                            CupertinoIcons.paperplane,
                            color: CupertinoColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class CommunitySettingModal extends StatelessWidget {
  const CommunitySettingModal({super.key, this.reverse = false});
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      child: SafeArea(
          top: false,
          child: ListView(
            reverse: reverse,
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Community Rules',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.book),
                // onTap: () => showCupertinoModalBottomSheet(
                //     expand: false,
                //     context: context,
                //     builder: ((context) => CommunityCreationModal(
                //           reverse: reverse,
                //         ))),
                onTap: () {
                  Navigator.of(context).pop(context);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const CommunityRulesPage()));
                },
              ),
              ListTile(
                title: const Text(
                  'Community Settings',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pop(context);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const CommunitySettingPage()));
                },
                // onTap: () => showCupertinoModalBottomSheet(
                //     expand: false,
                //     context: context,
                //     builder: ((context) => CommunityCreationModal(
                //           reverse: reverse,
                //         ))),
              ),
              ListTile(
                title: const Text(
                  'Leave Community',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.keyboard_return),
                onTap: () {
                  Navigator.pop(context);
                  _showLeaveCommunityDialog(context);
                },
                // onTap: () => showCupertinoModalBottomSheet(
                //     expand: false,
                //     context: context,
                //     builder: ((context) => CommunityListModal(
                //           reverse: reverse,
                //         ))),
              ),
            ],
          )),
    ));
  }
}

void _showLeaveCommunityDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Leave Community'),
      content: const Text('Are you sure want to leave this community?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

class CommunityDiscoverModal extends StatelessWidget {
  const CommunityDiscoverModal(
      {super.key, this.reverse = false, required this.discoverImage});
  final bool reverse;
  final String discoverImage;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      child: SafeArea(
        top: false,
        child: Container(
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
                                        image: AssetImage(discoverImage),
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
                const Text(
                  'ODBA',
                  style: TextStyle(
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
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: const Text(
                    "Devil's Reject Nation is a tight-knit company of motorcycle enthusiasts who share a passion for the open road and a love for are things two-wheeled. We're not your typical riders, we're a bothered and sisterhood of rebels, adventures, and free spirits who to together to embrace the thrill of a trip",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                // BUTTON JOIN DISINI
              ],
            )),
      ),
    ));
  }
}

class DiscoverCommunitiesCard extends StatefulWidget {
  const DiscoverCommunitiesCard({super.key, required this.communitiesImage});
  final String communitiesImage;

  @override
  State<DiscoverCommunitiesCard> createState() =>
      _DiscoverCommunitiesCardState();
}

class _DiscoverCommunitiesCardState extends State<DiscoverCommunitiesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              builder: (context) => CommunityDiscoverModal(
                    discoverImage: widget.communitiesImage,
                  ));
        },
        child: Container(
          width: 65,
          height: 65,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
              border: KonektoBorder.all(color: Colors.grey.shade400),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color: const Color(0xffECEFF1)),
          child: Image.asset(
            widget.communitiesImage,
            height: 55.0,
            width: 55.0,
          ),
        ));
  }
}
