import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/auth/register_page.dart';
import 'package:konekto/widgets/form/login_form_widget.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const LoginPage());

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            const LoginForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: 'New to Konekto? ',
                    style: TextStyle(
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const RegisterPage()));
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
