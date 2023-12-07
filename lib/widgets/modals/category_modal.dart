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
                      ),
                      CategoryModalItem(
                        categoryName: 'Volleyball',
                      ),
                      CategoryModalItem(
                        categoryName: 'Basketball',
                      ),
                      CategoryModalItem(
                        categoryName: 'Billiard',
                      ),
                      CategoryModalItem(
                        categoryName: 'Badminton',
                      ),
                      CategoryModalItem(
                        categoryName: 'Swimming',
                      ),
                      CategoryModalItem(
                        categoryName: 'Table Tennis',
                      ),
                      CategoryModalItem(
                        categoryName: 'Tennis',
                      ),
                      CategoryModalItem(
                        categoryName: 'Basketball',
                      ),
                      CategoryModalItem(
                        categoryName: 'Music',
                      ),
                      CategoryModalItem(
                        categoryName: 'Cooking',
                      ),
                      CategoryModalItem(
                        categoryName: 'Photography',
                      ),
                      CategoryModalItem(
                        categoryName: 'Gaming',
                      ),
                      CategoryModalItem(
                        categoryName: 'Painting',
                      ),
                      CategoryModalItem(
                        categoryName: 'Reading',
                      ),
                      CategoryModalItem(
                        categoryName: 'Travelling',
                      ),
                      CategoryModalItem(
                        categoryName: 'Programming',
                      ),
                      CategoryModalItem(
                        categoryName: 'Robotics',
                      ),
                      CategoryModalItem(
                        categoryName: 'Fishing',
                      ),
                      CategoryModalItem(
                        categoryName: 'Dance',
                      ),
                      CategoryModalItem(
                        categoryName: 'Writing',
                      ),
                      CategoryModalItem(
                        categoryName: 'Fitness',
                      ),
                      CategoryModalItem(
                        categoryName: 'Running',
                      ),
                      CategoryModalItem(
                        categoryName: 'Camping',
                      ),
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
