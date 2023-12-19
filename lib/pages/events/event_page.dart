import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/events/event_registration_page.dart';

/// Flutter code sample for [CupertinoPageScaffold].

class EventPage extends StatelessWidget {
  const EventPage({super.key, required this.eventName});
  final String eventName;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: Event(
        eventName: eventName,
      ),
    );
  }
}

class Event extends StatefulWidget {
  const Event({super.key, required this.eventName});
  final String eventName;

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.eventName),
          backgroundColor: CupertinoColors.white,
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(context),
          ),
        ),
        child: SafeArea(
          child: Column(
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
                        image: AssetImage("assets/images/event_detail.png"),
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
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'Open register from September 25, 2023',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: const Text(
                      "Kepri Cup 2023 is set to make its grand return this year, promising to be a sporting extravaganza like no other. Scheduled for October 30, 2023, this highly anticipated event will bring together athletes, sports enthusiasts, and spectators from all corners of the globe. The Kepri Cup is not just a competition; it's a celebration of human physical prowess and a testament to the unifying power of sports. With an array of sport categories on display, this event is poised to be a magnificent spectacle of athleticism, dedication, and camaraderie.",
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: const Text(
                      "Kepri Cup 2023 is set to make its grand return this year, promising to be a sporting extravaganza like no other. Scheduled for October 30, 2023, this highly anticipated event will bring together athletes, sports enthusiasts, and spectators from all corners of the globe. The Kepri Cup is not just a competition; it's a celebration of human physical prowess and a testament to the unifying power of sports. With an array of sport categories on display, this event is poised to be a magnificent spectacle of athleticism, dedication, and camaraderie.",
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: const Text(
                      "This year, the Kepri Cup will be held at the state-of-the-art Kepri Sports Complex, a sprawling facility designed to host a wide range of sporting activities. The complex boasts world-class amenities, including modern stadiums, well-maintained fields, and top-notch training facilities, ensuring that athletes are at the top of their game.",
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
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
                          builder: (context) => const EventRegistrationPage()));
                    }),
              )
            ],
          ),
        ));
  }
}
