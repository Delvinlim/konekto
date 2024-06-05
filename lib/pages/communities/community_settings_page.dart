import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SettingsType { community, members }

class CommunitySettingPage extends StatefulWidget {
  const CommunitySettingPage({super.key});

  @override
  State<CommunitySettingPage> createState() => _CommunitySettingState();
}

class _CommunitySettingState extends State<CommunitySettingPage> {
  SettingsType _selectedSegment = SettingsType.community;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Community Setting'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(context),
            },
          ),
        ),
        child: SafeArea(
            child: Column(children: [
          Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              width: double.infinity,
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.10,
                padding: const EdgeInsets.only(bottom: 10),
                child: CupertinoSlidingSegmentedControl<SettingsType>(
                  backgroundColor: CupertinoColors.systemGrey3,
                  thumbColor: Colors.blue.shade600,
                  // This represents the currently selected segmented control.
                  groupValue: _selectedSegment,
                  // Callback that sets the selected segmented control.
                  onValueChanged: (SettingsType? value) {
                    if (value != null) {
                      setState(() {
                        _selectedSegment = value;
                      });
                    }
                  },
                  children: const <SettingsType, Widget>{
                    SettingsType.community: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Community',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    SettingsType.members: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Members',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  },
                ),
              )),
          Expanded(
              child: SizedBox(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                if (_selectedSegment.name == 'community') ...[
                  const Text(
                    'Basic Community Info',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: const Text(
                          'Name and Description',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      )),
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: const Text(
                          'Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      )),
                  // GestureDetector(
                  //     onTap: () {},
                  //     child: Container(
                  //       margin: const EdgeInsets.symmetric(vertical: 6),
                  //       child: const Text(
                  //         'Cover',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w700, fontSize: 18),
                  //       ),
                  //     )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Since',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                        const Text(
                          'Date of establishment',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: CupertinoColors.inactiveGray),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Privacy',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                        const Text(
                          'Public',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: CupertinoColors.inactiveGray),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Location',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                        const Text(
                          'Community Base',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: CupertinoColors.inactiveGray),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: const Text(
                          'Community Rules',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      )),
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 8),
                        child: const Text(
                          'Manage Post',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        ),
                      )),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 6),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {},
                  //         child: const Text(
                  //           'Who can post',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w700, fontSize: 18),
                  //         ),
                  //       ),
                  //       const Text(
                  //         'Anyone in the community',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 16,
                  //             color: CupertinoColors.inactiveGray),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 6),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {},
                  //         child: const Text(
                  //           'Post approval',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w700, fontSize: 18),
                  //         ),
                  //       ),
                  //       const Text(
                  //         'Off',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 16,
                  //             color: CupertinoColors.inactiveGray),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://i.pravatar.cc/300',
                              height: 35.0,
                              width: 35.0,
                            ),
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Siti Aisyah Malik',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Admin',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Text(
                                //       '12:00',
                                //       textAlign: TextAlign.center,
                                //       style: TextStyle(
                                //         color: Color(0xff0689FF),
                                //         fontSize: 12,
                                //         fontFamily: 'Inter',
                                //         fontWeight: FontWeight.w400,
                                //       ),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://i.pravatar.cc/300',
                              height: 35.0,
                              width: 35.0,
                            ),
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rizky Pratama Nugroho',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Member',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: ShapeDecoration(
                                        color: CupertinoColors.systemPink,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Remove',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: CupertinoColors.white,
                                              fontSize: 12,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://i.pravatar.cc/300',
                              height: 35.0,
                              width: 35.0,
                            ),
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lina Susilo Wijaya',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Member',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: ShapeDecoration(
                                        color: CupertinoColors.systemPink,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Remove',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: CupertinoColors.white,
                                              fontSize: 12,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://i.pravatar.cc/300',
                              height: 35.0,
                              width: 35.0,
                            ),
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Budi Santoso Purnomo',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Member',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: ShapeDecoration(
                                        color: CupertinoColors.systemPink,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Remove',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: CupertinoColors.white,
                                              fontSize: 12,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ))
        ])));
  }
}
