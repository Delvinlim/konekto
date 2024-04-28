import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toastification/toastification.dart';
import 'package:konekto/models/notifications_response.dart'
    as KonektoNotification;

const _storage = FlutterSecureStorage();

class NotificationModal extends StatelessWidget {
  const NotificationModal(
      {super.key, this.reverse = false, required this.notification});
  final bool reverse;
  final KonektoNotification.Notification notification;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.all(16),
            reverse: reverse,
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                height: 36,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.50, color: Color(0xFFE2E2E2)),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: notification.notificationDetail?.type == 'system'
                            ? Image.asset(
                                "assets/images/logo.png",
                              )
                            : Image.network(
                                notification.notificationDetail?.imageUrl ??
                                    ''),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        notification.notificationDetail?.name ??
                            'Notification Sender',
                        style: const TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(notification.notificationDetail?.description ??
                    'Notification Description'),
              ),
              Expanded(
                child: CupertinoButton(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    color: CupertinoColors.destructiveRed,
                    child: const Text('Remove Notification',
                        style: TextStyle(
                            fontSize: 14,
                            // color: CupertinoColors.black,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {}),
              )
            ],
          )),
    );
  }
}
