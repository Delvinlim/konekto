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
                        image:
                            NetworkImage("https://via.placeholder.com/350x150"),
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
                  child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: const Text(
                      'Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello WoHello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World',
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: const Text(
                      'Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello WoHello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World',
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: const Text(
                      'Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello WoHello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World',
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                ],
              )),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: CupertinoButton(
                    // padding: const EdgeInsets.only(left: 24, right: 24),
                    color: Colors.blue.shade600,
                    child: const Text('Register Now',
                        style: TextStyle(
                            fontSize: 14,
                            // color: Colors.black,
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
