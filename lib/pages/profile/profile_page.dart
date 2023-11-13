import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_profile_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const ProfilePage());

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // Uncomment to change the background color
      // backgroundColor: CupertinoColors.systemPink,
      // navigationBar: const CupertinoNavigationBar(
      //   middle: Text('Profile'),
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 10, right: 10, bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            'assets/images/profile.png',
                            height: 50.0,
                            width: 50.0,
                          ),
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const Text(
                      //       'Delvin Lim',
                      //       style: TextStyle(
                      //           fontSize: 14, fontWeight: FontWeight.w400),
                      //     ),
                      //     Container(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 12.0, vertical: 6.0),
                      //       margin: const EdgeInsets.only(top: 4),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(16.0),
                      //         border: Border.all(
                      //           color: CupertinoColors.inactiveGray,
                      //         ),
                      //       ),
                      //       child: const Text(
                      //         '@username',
                      //         style: TextStyle(
                      //           fontSize: 12.0,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
                      Column(
                        children: [
                          Container(
                            width: 84,
                            height: 42,
                            margin: const EdgeInsets.only(top: 30, bottom: 10),
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
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0xFFE2E2E2),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                          '@username',
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
                                ),
                                const Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Text(
                                    'Jhon Doe',
                                    style: TextStyle(
                                      color: Colors.black,
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
                                builder: (context) => const ProfileModal());
                            // Navigator.push(
                            //     context,
                            //     CupertinoPageRoute(
                            //         builder: (context) =>
                            //             const NotificationsPage()));rr
                          },
                          child: const Icon(
                            CupertinoIcons.bars,
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
          // Container(
          //     padding: const EdgeInsets.symmetric(vertical: 12.0),
          //     margin: const EdgeInsets.only(top: 4, left: 10, right: 10),
          //     // padding: const EdgeInsets.symmetric(
          //     //     vertical: 40.0, horizontal: 10.0),
          //     decoration: BoxDecoration(
          //       color: const Color(0xfff6f6f6),
          //       borderRadius: BorderRadius.circular(24.0),
          //       border: Border.all(
          //         color: CupertinoColors.inactiveGray,
          //       ),
          //     ),
          //     child: const Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Column(
          //           children: [
          //             Text(
          //               '3',
          //               style: TextStyle(
          //                   fontSize: 18, fontWeight: FontWeight.w700),
          //             ),
          //             Text(
          //               'Communities',
          //               style: TextStyle(
          //                   fontSize: 12, fontWeight: FontWeight.w400),
          //             ),
          //           ],
          //         ),
          //         Column(
          //           children: [
          //             Text(
          //               '0',
          //               style: TextStyle(
          //                   fontSize: 18, fontWeight: FontWeight.w700),
          //             ),
          //             Text(
          //               'Communities',
          //               style: TextStyle(
          //                   fontSize: 12, fontWeight: FontWeight.w400),
          //             ),
          //           ],
          //         ),
          //         Column(
          //           children: [
          //             Text(
          //               '69',
          //               style: TextStyle(
          //                   fontSize: 18, fontWeight: FontWeight.w700),
          //             ),
          //             Text(
          //               'Communities',
          //               style: TextStyle(
          //                   fontSize: 12, fontWeight: FontWeight.w400),
          //             ),
          //           ],
          //         ),
          //       ],
          //     )),
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
                      color: Colors.black,
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
                      color: Colors.black,
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
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Positioned(
                  left: 60,
                  top: 13,
                  child: Text(
                    '3',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Positioned(
                  left: 214,
                  top: 13,
                  child: Text(
                    '69',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Positioned(
                  left: 138,
                  top: 13,
                  child: Text(
                    '0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
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
          // const Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: <Widget>[
          //       Center(
          //         child: Text('No Post Yet.'),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
