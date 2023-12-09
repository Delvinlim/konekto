import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/communities/community_detail_page.dart';
import 'package:konekto/utils/konekto_border.dart';

class CommunitiesCard extends StatelessWidget {
  const CommunitiesCard({super.key, required this.communityName});
  final String communityName;

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
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://via.placeholder.com/46x46"),
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
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Text(
//                       'Since 2019',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
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
  const ForYouCommunitiesCard({super.key});

  @override
  State<ForYouCommunitiesCard> createState() => _ForYouCommunitiesCardState();
}

class _ForYouCommunitiesCardState extends State<ForYouCommunitiesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.only(top: 12, bottom: 24, left: 12, right: 12),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: const ShapeDecoration(
                      color: Color(0xFFD9D9D9),
                      shape: OvalBorder(),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Football',
                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'John Doe',
                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 10,
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
                  color: Colors.black,
                  fontSize: 8,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              'Unleash your inner champion and join us for the ultimate battle of wits, skill, and determination! 🏆🔥 #CompetitionCraze #RiseToTheChallenge',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: 200,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: NetworkImage("https://via.placeholder.com/365x200"),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.84),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscoverCommunitiesCard extends StatefulWidget {
  const DiscoverCommunitiesCard({super.key});

  @override
  State<DiscoverCommunitiesCard> createState() =>
      _DiscoverCommunitiesCardState();
}

class _DiscoverCommunitiesCardState extends State<DiscoverCommunitiesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          border: KonektoBorder.all(color: Colors.grey.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          color: const Color(0xffD9D9D9)),
      child: Image.asset(
        'assets/images/football.png',
        height: 50.0,
        width: 50.0,
      ),
    );
  }
}
