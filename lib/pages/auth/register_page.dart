import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/auth/login_page.dart';
import 'package:konekto/widgets/form/register_form_widget.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const RegisterPage());

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // ),
            // const SizedBox(height: 60.0),

            // const SizedBox(height: 60.0),
            const RegisterForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                      text: 'Sign in',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const LoginPage()));
                        }),
                ]))
              ],
            )
          ],
        ),
      ),
    );
  }
}
