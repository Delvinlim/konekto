import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:konekto/utils/konekto_route.dart';
import 'package:konekto/widgets/appbar/app_bar_widget.dart';
import 'package:konekto/services/dio_service.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _register() async {
    try {
      UserCredential firebaseRes = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      print('check here firebase response');
      print(firebaseRes);
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: nameController.text,
          id: firebaseRes.user!.uid, // UID from Firebase Authentication
          imageUrl: 'https://i.pravatar.cc/300',
          lastName: nameController.text,
        ),
      );

      // Consume API
      dynamic res = await dioClient.post('/auth/register', data: {
        'name': nameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'firebaseId': firebaseRes.user!.uid
      });
      final response = json.decode(res.toString());
      // Save Token
      await FlutterSessionJwt.saveToken(response['token']);
      // await FirebaseChatCore.instance.createUserInFirestore(
      //   types.User(
      //     firstName: 'John',
      //     id: credential.user!.uid, // UID from Firebase Authentication
      //     imageUrl: 'https://i.pravatar.cc/300',
      //     lastName: 'Doe',
      //   ),
      // );

      // Show Notification
      // ignore: use_build_context_synchronously
      toastification.show(
        context: context,
        title: const Text("Registered"),
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
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.back,
                      color: CupertinoColors.black,
                      size: 36,
                    ))
              ],
            ),
          ),
          // Center(
          //   child: Image.asset(
          //     'assets/images/logo.png',
          //     width: 150.0,
          //     height: 150.0,
          //   ),
          // ),
          const Center(
              child: Text(
            "Register to Konekto",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          )),
          const SizedBox(height: 20.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Name',
                style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your name',
              controller: nameController,
              keyboardType: TextInputType.name,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Username',
                style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your username',
              controller: usernameController,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Email',
                style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Confirm Password',
                style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your password',
              controller: confirmPasswordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password confirmation';
                } else if (value != passwordController.text) {
                  return "Confirm password doesn't match with password";
                }
                return null;
              },
            ),
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.blue.shade600),
                ),
              )
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
                  child: const Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black);
                      _register();
                    }
                  }),
            ),
          ))
        ],
      ),
    );
  }
}
