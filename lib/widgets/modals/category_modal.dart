import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/widgets/modals/category_modal_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:konekto/pages/settings/settings_page.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

                const Wrap(
                  // alignment: WrapAlignment.start,
                  // crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                    CategoryModalItem(),
                  ],
                )
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
