import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:konekto/pages/events/event_registration_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

/// Flutter code sample for [CupertinoPageScaffold].

class Event extends StatefulWidget {
  const Event({super.key, required this.eventId, required this.eventName});
  final String eventId;
  final String eventName;

  @override
  State<Event> createState() => _EventState();
}

const _storage = FlutterSecureStorage();

class _EventState extends State<Event> {
  late Map eventDetail = {};
  bool isEventFetched = false;

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  void launchWhatsapp(String message, String phone) async {
    String queryMessage = Uri.encodeComponent(message);
    String queryPhone = Uri.encodeComponent(message);
    // String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    String whatsappUrl =
        "https://api.whatsapp.com/send/?phone=$queryPhone&text=$queryMessage&type=phone_number&app_absent=0";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    }
  }

  void fetchEvent() async {
    setState(() {
      // isProfileFetched = true;
      isEventFetched = true;
    });
    dynamic accessToken = await _storage.read(key: 'jwtToken');

    try {
      Response response = await dioClient.get(
          '/community/event/${widget.eventId}',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      if (response.statusCode == 200) {
        print('check my event response here....');
        print(response);
        print(response.data);
        // Successful response, parse the JSON
        setState(() {
          eventDetail = {
            'name': response.data['data']['name'],
            'subName': response.data['data']['subName'],
            'imageUrl': response.data['data']['imageUrl'],
            'description': response.data['data']['description'],
            'eventType': response.data['data']['eventType'],
          };
          isEventFetched = false;
          // profile = profileResponse;
          // isProfileFetched = false;
        });

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('user', json.encode(profileResponse));

        // Now you can use profileResponse
        // print('Profile ID: ${profileResponse.id}');
        // print('Profile Name: ${profileResponse.name}');
        // print('Profile Username: ${profileResponse.username}');
        // print('Profile Email: ${profileResponse.email}');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch profile data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      setState(() {
        // isProfileFetched = false;
        isEventFetched = false;
      });
      if (e.response?.data['message'] != null &&
          e.response?.statusCode != 429) {
        // ignore: use_build_context_synchronously
        toastification.show(
            context: context,
            title: Text(e.response?.data['message']),
            autoCloseDuration: const Duration(seconds: 3),
            type: ToastificationType.warning,
            style: ToastificationStyle.flatColored,
            alignment: Alignment.topCenter,
            direction: TextDirection.ltr,
            dragToClose: true,
            showProgressBar: false);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // ignore: use_build_context_synchronously
        toastification.show(
            context: context,
            title: e.message != null
                ? Text(e.response!.statusMessage!)
                : const Text("Server Error"),
            description: const Text(
              'Please try again later',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            autoCloseDuration: const Duration(seconds: 3),
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
            alignment: Alignment.topCenter,
            direction: TextDirection.ltr,
            dragToClose: true,
            showProgressBar: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.eventName),
          backgroundColor: CupertinoColors.white,
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => Navigator.of(context).pop(context),
          ),
        ),
        child: SafeArea(
            child: Skeletonizer(
          enabled: isEventFetched,
          child: isEventFetched
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          height: 150,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image:
                                  AssetImage("assets/images/event_detail.png"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.eventName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Open register from September 25, 2023',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12),
                          child: const Text(
                            "Kepri Cup 2023 is set to make its grand return this year, promising to be a sporting extravaganza like no other. Scheduled for October 30, 2023, this highly anticipated event will bring together athletes, sports enthusiasts, and spectators from all corners of the globe. The Kepri Cup is not just a competition; it's a celebration of human physical prowess and a testament to the unifying power of sports. With an array of sport categories on display, this event is poised to be a magnificent spectacle of athleticism, dedication, and camaraderie.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12),
                          child: const Text(
                            "Kepri Cup 2023 is set to make its grand return this year, promising to be a sporting extravaganza like no other. Scheduled for October 30, 2023, this highly anticipated event will bring together athletes, sports enthusiasts, and spectators from all corners of the globe. The Kepri Cup is not just a competition; it's a celebration of human physical prowess and a testament to the unifying power of sports. With an array of sport categories on display, this event is poised to be a magnificent spectacle of athleticism, dedication, and camaraderie.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12),
                          child: const Text(
                            "This year, the Kepri Cup will be held at the state-of-the-art Kepri Sports Complex, a sprawling facility designed to host a wide range of sporting activities. The complex boasts world-class amenities, including modern stadiums, well-maintained fields, and top-notch training facilities, ensuring that athletes are at the top of their game.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ),
                      ],
                    )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12, top: 12),
                      child: CupertinoButton(
                          // padding: const EdgeInsets.only(left: 24, right: 24),
                          color: Colors.blue.shade600,
                          child: const Text('Register Now',
                              style: TextStyle(
                                  fontSize: 14,
                                  // color: CupertinoColors.black,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) =>
                                    const EventRegistrationPage()));
                          }),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          height: 150,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(eventDetail['imageUrl']),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      eventDetail['name'] ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      eventDetail['subName'] ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12),
                          child: Text(
                            eventDetail['description'] ?? '',
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ),
                      ],
                    )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12, top: 12),
                      child: CupertinoButton(
                          // padding: const EdgeInsets.only(left: 24, right: 24),
                          color: Colors.blue.shade600,
                          child: const Text('Register Now',
                              style: TextStyle(
                                  fontSize: 14,
                                  // color: CupertinoColors.black,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            launchWhatsapp(
                                'Hi Konekto, saya mau registrasi untuk event ${eventDetail['eventName']}',
                                '+6282288521900');
                            // Navigator.of(context).push(CupertinoPageRoute(
                            //     builder: (context) =>
                            //         const EventRegistrationPage()));
                          }),
                    )
                  ],
                ),
        )));
  }
}
