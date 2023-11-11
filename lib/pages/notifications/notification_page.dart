import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/widgets/card/notification_card_widget.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const NotificationsPage());

enum NotificationType { all, system, community, midnight, viridian, cerulean }

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Notifications(),
    );
  }
}

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationType _selectedSegment = NotificationType.all;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        // navigationBar: const CupertinoNavigationBar(
        //   middle: Text('Home'),
        // ),
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Notification'),
          leading: CupertinoNavigationBarBackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
                width: double.infinity,
                child: SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.10,
                  child: CupertinoSlidingSegmentedControl<NotificationType>(
                    backgroundColor: CupertinoColors.systemGrey2,
                    thumbColor: Colors.blue.shade600,
                    // This represents the currently selected segmented control.
                    groupValue: _selectedSegment,
                    // Callback that sets the selected segmented control.
                    onValueChanged: (NotificationType? value) {
                      if (value != null) {
                        setState(() {
                          _selectedSegment = value;
                        });
                      }
                    },
                    children: const <NotificationType, Widget>{
                      NotificationType.all: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'All',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                      NotificationType.system: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'System',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                      NotificationType.community: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Community',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                    },
                  ),
                )),
            Expanded(
                child: SizedBox(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  NotificationCard(
                    selectedSegment: _selectedSegment.name,
                  ),
                  NotificationCard(
                    selectedSegment: _selectedSegment.name,
                  ),
                  NotificationCard(
                    selectedSegment: _selectedSegment.name,
                  ),
                  SystemNotificationCard(
                      selectedSegment: _selectedSegment.name),
                  SystemNotificationCard(
                      selectedSegment: _selectedSegment.name),
                  SystemNotificationCard(
                      selectedSegment: _selectedSegment.name),
                  NotificationCard(
                    selectedSegment: _selectedSegment.name,
                  ),
                  SystemNotificationCard(
                      selectedSegment: _selectedSegment.name),
                  NotificationCard(
                    selectedSegment: _selectedSegment.name,
                  ),
                  SystemNotificationCard(
                      selectedSegment: _selectedSegment.name),
                  NotificationCard(
                    selectedSegment: _selectedSegment.name,
                  ),
                  SystemNotificationCard(
                      selectedSegment: _selectedSegment.name),
                  Container(
                    height: 50,
                    color: Colors.amber[100],
                    child: Center(
                        child: Text(
                      'Selected Segment: ${_selectedSegment.name}',
                    )),
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
