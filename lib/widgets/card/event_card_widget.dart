import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/events/event_page.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventCard extends StatefulWidget {
  const EventCard(
      {super.key, required this.eventName, required this.eventImage});
  final String? eventName;
  final String? eventImage;

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
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: KonektoBorder.all(color: CupertinoColors.black),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 85,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      widget.eventImage ?? ''), //TODO Default network image
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              child: Text(
                widget.eventName ?? 'Default Event Name',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Skeleton.ignore(
                child: CupertinoButton(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    color: CupertinoColors.activeBlue,
                    child: const Text('View Details',
                        style: TextStyle(
                            fontSize: 14,
                            // color: CupertinoColors.black,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => Event(
                                eventName:
                                    widget.eventName ?? 'Default Event Name',
                              )));
                    }))
          ],
        ));
  }
}
