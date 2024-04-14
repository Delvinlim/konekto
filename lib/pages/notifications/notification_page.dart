import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/models/notifications_response.dart'
    as KonektoNotification;
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/widgets/card/notification_card_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

enum NotificationType { all, system, community }

const _storage = FlutterSecureStorage();

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationType _selectedSegment = NotificationType.all;

  bool isNotificationsFetched = false;
  late List<KonektoNotification.Notification> notificationsList = [];

  @override
  void initState() {
    super.initState();
    _getNotifications();
  }

  void _getNotifications() async {
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    setState(() {
      isNotificationsFetched = true;
    });
    try {
      Response response = await dioClient.get('/me/notifications',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));
      if (response.statusCode == 200) {
        // Successful response, parse the JSON
        Map<String, dynamic> responseData = response.data;
        KonektoNotification.NotificationsResponse notificationsResponse =
            KonektoNotification.NotificationsResponse.fromJson(responseData);
        setState(() {
          notificationsList = notificationsResponse.notifications ?? [];
          isNotificationsFetched = false;
        });
        // Successful response, parse the JSON
        print('notification...');
        for (var i = 0; i < notificationsResponse.notifications!.length; i++) {
          print(notificationsResponse.notifications?[i].id);
          print(
              notificationsResponse.notifications?[i].notificationDetail?.type);
        }
        print(notificationsResponse.notifications);
        print('end response');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch notification data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      setState(() {
        isNotificationsFetched = false;
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
              'Failed to get notifications',
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

  void _deleteNotification(String notificationId) async {
    setState(() {
      notificationsList
          .removeWhere((notification) => notification.id == notificationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Notification'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => Navigator.of(context).pop(context),
          ),
          // trailing: GestureDetector(
          //   child: const Icon(
          //     CupertinoIcons.trash,
          //     color: CupertinoColors.black,
          //     size: 20,
          //   ),
          // ),
        ),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
                width: double.infinity,
                child: SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.10,
                  child: CupertinoSlidingSegmentedControl<NotificationType>(
                    backgroundColor: CupertinoColors.systemGrey3,
                    thumbColor: Colors.blue.shade600,
                    groupValue: _selectedSegment,
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
                          style: TextStyle(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      NotificationType.system: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'System',
                          style: TextStyle(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      NotificationType.community: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Community',
                          style: TextStyle(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    },
                  ),
                )),
            Expanded(
                child: SizedBox(
                    child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          // Swiping in right direction.
                          // print(details);
                          if (details.primaryVelocity! > 0) {
                            print('swipe right');
                            if (_selectedSegment.name == 'system') {
                              setState(() {
                                _selectedSegment = NotificationType.all;
                              });
                            } else if (_selectedSegment.name == 'community') {
                              setState(() {
                                _selectedSegment = NotificationType.system;
                              });
                            }
                          }

                          // Swiping in left direction.
                          if (details.primaryVelocity! < 0) {
                            print('swipe left');
                            if (_selectedSegment.name == 'all') {
                              setState(() {
                                _selectedSegment = NotificationType.system;
                              });
                            } else if (_selectedSegment.name == 'system') {
                              setState(() {
                                _selectedSegment = NotificationType.community;
                              });
                            }
                          }
                        },
                        child: Skeletonizer(
                          enabled: isNotificationsFetched,
                          child: isNotificationsFetched ||
                                  notificationsList.isEmpty
                              ? isNotificationsFetched
                                  ? ListView(
                                      children: [
                                        // Fake Data
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width, // Match screen width
                                            height: 64,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 10),
                                            child: const Bone.square(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              size: 20,
                                            )),
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width, // Match screen width
                                            height: 64,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 10),
                                            child: const Bone.square(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              size: 20,
                                            )),
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width, // Match screen width
                                            height: 64,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 10),
                                            child: const Bone.square(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              size: 20,
                                            )),
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width, // Match screen width
                                            height: 64,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 10),
                                            child: const Bone.square(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              size: 20,
                                            )),
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width, // Match screen width
                                            height: 64,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 10),
                                            child: const Bone.square(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              size: 20,
                                            )),
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width, // Match screen width
                                            height: 64,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 10),
                                            child: const Bone.square(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              size: 20,
                                            )),
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width, // Match screen width
                                            height: 64,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 10),
                                            child: const Bone.square(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              size: 20,
                                            )),
                                      ],
                                    )
                                  : const Center(
                                      child: Text('Empty Notification'),
                                    )
                              : ListView(
                                  padding: const EdgeInsets.all(8),
                                  children: [
                                    for (var notification in notificationsList)
                                      if (_selectedSegment.name ==
                                          'system') ...[
                                        if (notification
                                                .notificationDetail?.type ==
                                            'system')
                                          Dismissible(
                                              key: Key(notification.id!),
                                              direction: DismissDirection
                                                  .endToStart, // Allow left-to-right swipe
                                              onDismissed:
                                                  (DismissDirection direction) {
                                                // Implement delete logic here
                                                _deleteNotification(
                                                    notification.id!);
                                              },
                                              background: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                    color: CupertinoColors
                                                        .destructiveRed, //,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x19000000),
                                                        blurRadius: 8,
                                                        offset: Offset(0, 3),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: const Text(
                                                    'Hapus',
                                                    style: TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              child: SystemNotificationCard(
                                                notificationMessage:
                                                    notification
                                                        .notificationDetail
                                                        ?.description,
                                              )),
                                      ] else if (_selectedSegment.name ==
                                          'community') ...[
                                        if (notification
                                                .notificationDetail?.type ==
                                            'community')
                                          Dismissible(
                                              key: Key(notification.id!),
                                              direction: DismissDirection
                                                  .endToStart, // Allow left-to-right swipe
                                              onDismissed:
                                                  (DismissDirection direction) {
                                                _deleteNotification(
                                                    notification.id!);
                                              },
                                              background: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    color: CupertinoColors
                                                        .destructiveRed, //,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x19000000),
                                                        blurRadius: 8,
                                                        offset: Offset(0, 3),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: const Text(
                                                    'Hapus',
                                                    style: TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              child: NotificationCard(
                                                notificationMessage:
                                                    notification
                                                        .notificationDetail
                                                        ?.description,
                                                communityName: notification
                                                    .notificationDetail?.name,
                                                communityImage: notification
                                                    .notificationDetail
                                                    ?.imageUrl,
                                              )),
                                      ] else ...[
                                        if (notification
                                                .notificationDetail?.type ==
                                            'system')
                                          Dismissible(
                                              key: Key(notification.id!),
                                              direction: DismissDirection
                                                  .endToStart, // Allow left-to-right swipe
                                              onDismissed:
                                                  (DismissDirection direction) {
                                                // Implement delete logic here
                                                _deleteNotification(
                                                    notification.id!);
                                              },
                                              background: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                    color: CupertinoColors
                                                        .destructiveRed, //,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x19000000),
                                                        blurRadius: 8,
                                                        offset: Offset(0, 3),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: const Text(
                                                    'Hapus',
                                                    style: TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              child: SystemNotificationCard(
                                                notificationMessage:
                                                    notification
                                                        .notificationDetail
                                                        ?.description,
                                              ))
                                        else if (notification
                                                .notificationDetail?.type ==
                                            'community')
                                          Dismissible(
                                              key: Key(notification.id!),
                                              direction: DismissDirection
                                                  .endToStart, // Allow left-to-right swipe
                                              onDismissed:
                                                  (DismissDirection direction) {
                                                _deleteNotification(
                                                    notification.id!);
                                              },
                                              background: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    color: CupertinoColors
                                                        .destructiveRed, //,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x19000000),
                                                        blurRadius: 8,
                                                        offset: Offset(0, 3),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: const Text(
                                                    'Hapus',
                                                    style: TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              child: NotificationCard(
                                                notificationMessage:
                                                    notification
                                                        .notificationDetail
                                                        ?.description,
                                                communityName: notification
                                                    .notificationDetail?.name,
                                                communityImage: notification
                                                    .notificationDetail
                                                    ?.imageUrl,
                                              )),
                                      ],
                                  ],
                                ),
                        ))))
          ],
        ));
  }
}
