import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationCard extends StatefulWidget {
  const LocationCard(
      {super.key,
      required this.placeId,
      required this.placeName,
      required this.placeImage});
  final String placeId;
  final String placeName;
  final String placeImage;

  @override
  State<LocationCard> createState() => _LocationCardState();
}

void launchMap(String address) async {
  String query = Uri.encodeComponent(address);
  String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

  if (await canLaunchUrl(Uri.parse(googleUrl))) {
    await launchUrl(Uri.parse(googleUrl));
  }
}

class _LocationCardState extends State<LocationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        // height: 170,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        decoration: BoxDecoration(
          border: KonektoBorder.all(color: CupertinoColors.black),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 100,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.placeImage),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              child: Text(
                widget.placeName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            CupertinoButton(
                padding: const EdgeInsets.only(left: 24, right: 24),
                color: Colors.blue.shade600,
                child: const Text('View Location',
                    style: TextStyle(
                        fontSize: 14,
                        // color: CupertinoColors.black,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  launchMap(widget.placeName.toString());
                })
          ],
        ));
  }
}
