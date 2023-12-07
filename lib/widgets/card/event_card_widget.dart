import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        // height: 170,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: KonektoBorder.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            // Positioned(
            //   child: Container(
            //     width: 200,
            //     height: 85,
            //     decoration: ShapeDecoration(
            //       image: const DecorationImage(
            //         image: AssetImage("assets/images/event_1.png"),
            //         fit: BoxFit.fill,
            //       ),
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(6)),
            //     ),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              child: const Text(
                '2023 Kepri Cup',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            CupertinoButton(
                padding: const EdgeInsets.only(left: 24, right: 24),
                color: Colors.blue.shade600,
                child: const Text('View Details',
                    style: TextStyle(
                        fontSize: 14,
                        // color: Colors.black,
                        fontWeight: FontWeight.bold)),
                onPressed: () {})
          ],
        ));
  }
}
