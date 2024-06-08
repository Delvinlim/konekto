import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konekto/pages/home/home_page.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:toastification/toastification.dart';

const _storage = FlutterSecureStorage();

class AuthSettingPage extends StatefulWidget {
  const AuthSettingPage({super.key});

  @override
  State<AuthSettingPage> createState() => _AuthSettingState();
}

void _showPasswordChangedDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Success'),
      content: const Text('Your Password has been changed!'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

class _AuthSettingState extends State<AuthSettingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var currentController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');
  var confirmPasswordController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  void _updatePassword() async {
    try {
      dynamic accessToken = await _storage.read(key: 'jwtToken');
      // await FirebaseChatCore.instance.room(roomId)
      print('hello');
      Response res = await dioClient
          .put('/auth/me/password',
              data: {
                'current': currentController.text,
                'password': passwordController.text
              },
              options:
                  Options(headers: {"Authorization": 'Bearer $accessToken'}))
          .timeout(const Duration(seconds: 30));
      final response = json.decode(res.toString());

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          user.updatePassword(passwordController.text);
        }
      });
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
          // Navigator.pop(context);
          // // _showCommunityCreatedDialog(context, communityName),
          // Navigator.of(context, rootNavigator: true).pushReplacement(
          //     CupertinoPageRoute(builder: (context) => const HomePage()));
          Navigator.pop(context);
          Navigator.pop(context);
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
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Change Password'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(context),
            },
          ),
        ),
        child: Form(
          key: _formKey,
          child: SafeArea(
              child: Container(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Current Password',
                      style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.black,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 60,
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter your current password',
                    controller: currentController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4.0),
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey.shade400),
                        border: KonektoBorder.all(color: Colors.grey.shade400),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some current password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 7.0),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                  child: Text('New Password',
                      style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.black,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 60,
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter your new password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4.0),
                    decoration: BoxDecoration(
                        border: KonektoBorder.all(color: Colors.grey.shade400),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter new password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 7.0),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                  child: Text('Confirm Password',
                      style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.black,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 60,
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Enter your confirm password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: confirmPasswordController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4.0),
                    decoration: BoxDecoration(
                        border: KonektoBorder.all(color: Colors.grey.shade400),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    validator: (String? value) {
                      if (value == null ||
                          value.isEmpty ||
                          value != passwordController.text) {
                        return 'Please confirm your new password';
                      }
                      return null;
                    },
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                        color: Colors.blue.shade600,
                        child: const Text('Change Password'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            EasyLoading.show(
                                status: 'loading...',
                                maskType: EasyLoadingMaskType.black);
                            _updatePassword();
                            // Navigator.pushReplacement(
                            //     context,
                            //     CupertinoPageRoute(
                            //         builder: (context) => const KonektoTabBar()));
                            // Navigator.pushReplacement(
                            //     context,
                            //     CupertinoPageRoute(
                            //         builder: (context) => const KonektoTabBar()));
                          }
                        }),
                  ),
                ))
              ],
            ),
          )),
        ));
  }
}
