import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/auth/forget_password_page.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:konekto/utils/konekto_route.dart';
import 'package:konekto/widgets/appbar/app_bar_widget.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final dio = Dio();

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() async {
    try {
      // Consume API
      dynamic res = await dioClient.post('/auth/login', data: {
        'email': emailController.text,
        'password': passwordController.text
      });
      final response = json.decode(res.toString());

      // Save Token
      await FlutterSessionJwt.saveToken(response['token']);

      // Show Notification
      // ignore: use_build_context_synchronously
      toastification.show(
        context: context,
        title: const Text("Success"),
        description: const Text(
          'Please wait a moment...',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        alignment: Alignment.topCenter,
        direction: TextDirection.ltr,
        showProgressBar: false,
        closeButtonShowType: CloseButtonShowType.none,
        callbacks: ToastificationCallbacks(
            onAutoCompleteCompleted: (toastItem) =>
                Navigator.pushAndRemoveUntil(
                    context,
                    FadeRoute(page: const KonektoTabBar()),
                    ((route) => false))),
      );

      await EasyLoading.dismiss();
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print('error...');
      print(e);
      print(e.response?.statusCode);
      print(e.response);
      print(e.message);
      print('\n');
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
            autoCloseDuration: const Duration(seconds: 3),
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
            alignment: Alignment.topCenter,
            direction: TextDirection.ltr,
            dragToClose: true,
            showProgressBar: false);
      }
      if (e.message != null) {}

      await EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset('assets/images/logo.png'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Username / Email',
                style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your username or email',
              controller: emailController,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey.shade400),
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  // return Container(child: Text('Please enter your username or email'))
                  return 'Please enter your username or email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 14.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
            child: Text('Password',
                style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your password',
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const ForgetPassword()));
                    },
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500),
                    ),
                  ))
            ],
          ),
          Center(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                  color: Colors.blue.shade600,
                  child: const Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black);
                      _login();
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     FadeRoute(page: const KonektoTabBar()),
                      //     ((route) => false));
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     CupertinoPageRoute(
                      //         builder: (context) => const KonektoTabBar()),
                      //     ((route) => false));
                    }
                  }),
            ),
          ))
        ],
      ),
    );
  }
}
