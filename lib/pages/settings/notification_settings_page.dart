import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/widgets/item/notification_settings_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

const _storage = FlutterSecureStorage();

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSettingPage> {
  Map notificationPreferences = {
    // 'isLikeUpdate': false,
    // 'isCommentUpdate': false,
    // 'isAnnouncementUpdate': true,
    // 'isPostUpdate': false
  };
  bool isNotificationPreferencesFetched = false;

  @override
  void initState() {
    super.initState();
    _fetchNotificationPreference();
  }

  void _fetchNotificationPreference() async {
    dynamic accessToken = await _storage.read(key: 'jwtToken');
    setState(() {
      isNotificationPreferencesFetched = true;
    });
    try {
      Response res = await dioClient.get('/me/notification/preferences',
          options: Options(headers: {"Authorization": 'Bearer $accessToken'}));

      if (res.statusCode == 200) {
        // Successful response, parse the JSON
        print('notification preferences list.....');
        final response = json.decode(res.toString());
        print(response['data']);
        if (response['data'] != null) {
          setState(() {
            notificationPreferences = response['data'];
          });
        }
        print(notificationPreferences);
        print('end notif preferences response');
      } else {
        // Handle error response (non-200 status code)
        print('Failed to fetch notification data: ${res.statusCode}');
      }
      setState(() {
        isNotificationPreferencesFetched = false;
      });
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error post...');
      print(e);
      setState(() {
        isNotificationPreferencesFetched = false;
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
              'Failed to get notification preferences',
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
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Notification'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(context),
            },
          ),
        ),
        child: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information Detail',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                    child: Skeletonizer(
                  ignoreContainers: true,
                  enabled: isNotificationPreferencesFetched,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Color(0xffF6F6F6)),
                    // padding: const EdgeInsets.only(
                    //     top: 10, left: 10, right: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NotificationSettingsItem(
                            name: 'Likes',
                            value: notificationPreferences['isLikeUpdate'] ??
                                false),
                        NotificationSettingsItem(
                            name: 'Comments',
                            value: notificationPreferences['isCommentUpdate'] ??
                                false),
                        NotificationSettingsItem(
                            name: 'Announcement',
                            value: notificationPreferences[
                                    'isAnnouncementUpdate'] ??
                                false),
                        NotificationSettingsItem(
                            name: 'Community Post',
                            value: notificationPreferences['isPostUpdate'] ??
                                false),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ])));
  }
}
