import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/widgets/modals/category_modal_item.dart';

class CategoryModal extends StatelessWidget {
  const CategoryModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     CupertinoPageRoute(
                          //         builder: (context) =>
                          //             const ForgetPasswordPage()));
                        },
                        child: const Icon(
                          CupertinoIcons.xmark,
                          color: CupertinoColors.black,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

                const SizedBox(
                  width: double.maxFinite,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,

                    // alignment: WrapAlignment.start,
                    // crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      CategoryModalItem(
                          categoryName: 'Football',
                          categoryImage:
                              'assets/images/categories/football.png'),
                      CategoryModalItem(
                          categoryName: 'Volleyball',
                          categoryImage:
                              'assets/images/categories/volleyball.png'),
                      CategoryModalItem(
                          categoryName: 'Basketball',
                          categoryImage:
                              'assets/images/categories/basketball.png'),
                      CategoryModalItem(
                          categoryName: 'Billiard',
                          categoryImage:
                              'assets/images/categories/billiard.png'),
                      CategoryModalItem(
                          categoryName: 'Badminton',
                          categoryImage:
                              'assets/images/categories/badminton.png'),
                      CategoryModalItem(
                          categoryName: 'Swimming',
                          categoryImage:
                              'assets/images/categories/swimming.png'),
                      CategoryModalItem(
                          categoryName: 'Table Tennis',
                          categoryImage:
                              'assets/images/categories/table-tennis.png'),
                      CategoryModalItem(
                          categoryName: 'Tennis',
                          categoryImage: 'assets/images/categories/tennis.png'),
                      CategoryModalItem(
                          categoryName: 'Basketball',
                          categoryImage:
                              'assets/images/categories/basketball.png'),
                      CategoryModalItem(
                          categoryName: 'Music',
                          categoryImage: 'assets/images/categories/music.png'),
                      CategoryModalItem(
                          categoryName: 'Cooking',
                          categoryImage:
                              'assets/images/categories/cooking.png'),
                      CategoryModalItem(
                          categoryName: 'Photography',
                          categoryImage: 'assets/images/categories/tennis.png'),
                      CategoryModalItem(
                          categoryName: 'Gaming',
                          categoryImage: 'assets/images/categories/gaming.png'),
                      CategoryModalItem(
                          categoryName: 'Painting',
                          categoryImage:
                              'assets/images/categories/painting.png'),
                      CategoryModalItem(
                          categoryName: 'Reading',
                          categoryImage:
                              'assets/images/categories/reading.png'),
                      CategoryModalItem(
                          categoryName: 'Travelling',
                          categoryImage:
                              'assets/images/categories/travelling.png'),
                      CategoryModalItem(
                          categoryName: 'Programming',
                          categoryImage:
                              'assets/images/categories/programming.png'),
                      CategoryModalItem(
                          categoryName: 'Robotics',
                          categoryImage:
                              'assets/images/categories/robotics.png'),
                      CategoryModalItem(
                          categoryName: 'Fishing',
                          categoryImage:
                              'assets/images/categories/fishing.png'),
                      CategoryModalItem(
                          categoryName: 'Dance',
                          categoryImage: 'assets/images/categories/dance.png'),
                      CategoryModalItem(
                          categoryName: 'Writing',
                          categoryImage:
                              'assets/images/categories/writing.png'),
                      CategoryModalItem(
                          categoryName: 'Fitness',
                          categoryImage:
                              'assets/images/categories/fitness.png'),
                      CategoryModalItem(
                          categoryName: 'Running',
                          categoryImage:
                              'assets/images/categories/running.png'),
                      CategoryModalItem(
                          categoryName: 'Camping',
                          categoryImage:
                              'assets/images/categories/camping.png'),
                    ],
                  ),
                ),
                // const Flexible(
                //   child: Wrap(
                //     crossAxisAlignment: WrapCrossAlignment.center,
                //     alignment: WrapAlignment.spaceBetween,
                //     direction: Axis.horizontal,
                //     spacing: 30,
                //     children: [],
                //   ),
                // ),
              ],
            ),
          )
        ],
        // Column(
        //   children: [
        //     Row(
        //       children: [
        //         Container(
        //           padding: const EdgeInsets.only(
        //               top: 40, left: 10, right: 10, bottom: 10),
        //           child: const Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 'Message',
        //                 style: TextStyle(
        //                     fontSize: 24, fontWeight: FontWeight.bold),
        //               )
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ),
    ));
  }
}
