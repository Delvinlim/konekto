import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/widgets/form/forget_password_form_widget.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const ForgetPasswordPage());

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: ForgetPassword(),
    );
  }
}

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage("assets/images/cat2.jpg"),
      //       fit: BoxFit.cover),
      // ),
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/auth_background.png"),
              fit: BoxFit.cover)),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // ),
            // const SizedBox(height: 60.0),

            // const SizedBox(height: 60.0),
            ForgetPasswordForm(),
          ],
        ),
      ),
    );
  }
}
