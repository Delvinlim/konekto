import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/models/profile_response.dart';
import 'package:konekto/pages/settings/account_settings_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

const _storage = FlutterSecureStorage();

class AccountSettingModal extends StatefulWidget {
  const AccountSettingModal(
      {super.key,
      this.reverse = false,
      required this.identifier,
      required this.name,
      required this.value});
  final bool reverse;
  final String identifier;
  final String name;
  final String value;

  @override
  State<AccountSettingModal> createState() => _AccountSettingStateModal();
}

// class AccountSettingModal extends StatelessWidget {
class _AccountSettingStateModal extends State<AccountSettingModal> {
  static final GlobalKey<FormState> _accountSettingKey = GlobalKey<FormState>();

  var inputController = TextEditingController(text: '');

  bool isCategoriesFetched = false;

  @override
  void initState() {
    super.initState();
    inputController.text = widget.value;
  }

  void _updateProfile() async {
    try {
      dynamic accessToken = await _storage.read(key: 'jwtToken');
      // await FirebaseChatCore.instance.room(roomId)
      print('hello');
      Response res = await dioClient
          .put('/auth/me',
              data: {widget.identifier: inputController.text},
              options:
                  Options(headers: {"Authorization": 'Bearer $accessToken'}))
          .timeout(const Duration(seconds: 30));
      final response = json.decode(res.toString());
      print('check response..');
      print(response);
      print('end response..');
      EasyLoading.dismiss();
      // Show Notification
      // ignore: use_build_context_synchronously
      toastification.show(
        context: context,
        title: const Text("Success"),
        description: const Text(
          'Please wait a moment...',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        autoCloseDuration: const Duration(seconds: 2),
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        alignment: Alignment.topCenter,
        direction: TextDirection.ltr,
        dragToClose: false,
        showProgressBar: false,
        closeButtonShowType: CloseButtonShowType.none,
        callbacks:
            ToastificationCallbacks(onAutoCompleteCompleted: (toastItem) async {
          Response response = await dioClient.get('/auth/me',
              options:
                  Options(headers: {"Authorization": 'Bearer $accessToken'}));
          if (response.statusCode == 200) {
            // Successful response, parse the JSON
            Map<String, dynamic> responseData = response.data;
            ProfileResponse profileResponse =
                ProfileResponse.fromJson(responseData);
            // setState(() {
            //   profile = profileResponse;
            //   isProfileFetched = false;
            // });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('user', json.encode(profileResponse));
          }
          Navigator.pop(context);
          // _showCommunityCreatedDialog(context, communityName),
          Navigator.of(context, rootNavigator: true).pushReplacement(
              CupertinoPageRoute(
                  builder: (context) => const AccountSettingPage()));
        }),
      );
    } on DioException catch (e) {
      // cancelToken.cancel();
      EasyLoading.dismiss();
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response?.statusCode != 429) {
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
        // print(e.requestOptions);
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
    // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
    // ignore: no_leading_underscores_for_local_identifiers
    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
    }

    return CupertinoPageScaffold(
      child: SafeArea(
          top: true,
          child: ListView(
            reverse: widget.reverse,
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            children: [
              Text(
                'Edit ${widget.name}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  child: Form(
                    key: _accountSettingKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              child: CupertinoTextFormFieldRow(
                                keyboardType: TextInputType.name,
                                controller: inputController,
                                placeholder: widget.name,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey.shade400),
                                    border: KonektoBorder.all(
                                        color: Colors.grey.shade400),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter ${widget.name}';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  )),

              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: const Text('Cancel',
                            style: TextStyle(
                                fontSize: 14,
                                // color: CupertinoColors.black,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CupertinoButton(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        color: Colors.blue.shade600,
                        child: const Text('Confirm',
                            style: TextStyle(
                                fontSize: 14,
                                // color: CupertinoColors.black,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          if (_accountSettingKey.currentState!.validate()) {
                            EasyLoading.show(
                                status: 'loading...',
                                maskType: EasyLoadingMaskType.black);
                            _updateProfile();
                          }
                        }),
                  )
                ],
              )

              // ListTile(
              //   title: const Text(
              //     'ODBA',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              //   subtitle: const Text('Last updated 1 hour ago'),
              //   leading: const Icon(Icons.people),
              //   onTap: () => Navigator.of(context, rootNavigator: true).push(
              //       CupertinoPageRoute(
              //           builder: (context) => const SettingsPage())),
              // ),
            ],
          )),
    );
  }
}
