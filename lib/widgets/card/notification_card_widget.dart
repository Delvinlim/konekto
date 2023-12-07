import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({super.key, required this.selectedSegment});
  final String selectedSegment;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 344,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Positioned(
            left: 9,
            top: 10,
            child: SizedBox(
              width: 36,
              height: 36,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/36x36"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 53,
            top: 15,
            child: SizedBox(
              width: 198,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 198,
                    child: Text(
                      'ODBA',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 198,
                    child: Text(
                      'Rohim is currently posted something in ODBA',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        // height: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 251.93,
            top: 20,
            child: SizedBox(
              width: 80.94,
              child: Text(
                '10 minutes ago',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF0689FF),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SystemNotificationCard extends StatefulWidget {
  const SystemNotificationCard({super.key, required this.selectedSegment});
  final String selectedSegment;

  @override
  State<SystemNotificationCard> createState() => _SystemNotificationCardState();
}

class _SystemNotificationCardState extends State<SystemNotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: 400,
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 8,
                offset: Offset(0, 3),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                width: 390,
                height: 24,
                decoration: const BoxDecoration(
                  border: Border(
                    // left: BorderSide(color: Color(0xFFE2E2E2)),
                    // top: BorderSide(color: Color(0xFFE2E2E2)),
                    // right: BorderSide(color: Color(0xFFE2E2E2)),
                    bottom: BorderSide(width: 0.50, color: Color(0xFFE2E2E2)),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 15,
                      height: 15,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/15x15"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    const SizedBox(
                      width: 222,
                      height: 14,
                      child: Text(
                        'System',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                width: 390,
                child: const Text(
                  'Looking for affordable and reliable community costumes? Tania Store has the answer, as we can customize anything from clothing to discounted merchandise up to 60%!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                width: 390,
                height: 24,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  border: Border(
                    // left: BorderSide(color: Color(0xFFE2E2E2)),
                    // top: BorderSide(color: Color(0xFFE2E2E2)),
                    // right: BorderSide(color: Color(0xFFE2E2E2)),
                    top: BorderSide(width: 0.50, color: Color(0xFFE2E2E2)),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                        color: Color(0xFF0689FF),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 269),
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: Stack(children: []),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
