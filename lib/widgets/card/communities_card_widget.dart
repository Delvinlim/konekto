import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';

class CommunitiesCard extends StatelessWidget {
  const CommunitiesCard({super.key});

  // @override
  // State<CommunitiesCard> createState() => _CommunitiesCardState();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 130,
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 52,
                height: 52,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFECEFF1),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      child: SizedBox(
                        width: 46,
                        height: 46,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ODBA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Since 2019',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Inter',
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
    );
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
    return Column(
      children: [
        SizedBox(
          width: 375,
          height: 352,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 375,
                  height: 343,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ),
              Positioned(
                left: 13.45,
                top: 9.11,
                child: Container(
                  width: 41.78,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              const Positioned(
                left: 63.72,
                top: 17,
                child: SizedBox(
                  width: 65.37,
                  height: 28.30,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: SizedBox(
                          width: 65.37,
                          height: 15.98,
                          child: Text(
                            'Football',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.33,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -0,
                        top: 14.32,
                        child: SizedBox(
                          width: 53.90,
                          height: 13.99,
                          child: Text(
                            'John Doe',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.42,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 303.97,
                top: 26.03,
                child: SizedBox(
                  width: 57.34,
                  height: 9.99,
                  child: Text(
                    'October, 3 2023',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 6.51,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 13.58,
                top: 59.87,
                child: SizedBox(
                  width: 348.11,
                  height: 88.50,
                  child: Text(
                    'Unleash your inner champion and join us for the ultimate battle of wits, skill, and determination! 🏆🔥 #CompetitionCraze #RiseToTheChallenge',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.73,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 13,
                top: 118,
                child: Container(
                  width: 352,
                  height: 204,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image:
                          NetworkImage("https://via.placeholder.com/352x204"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.84),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
