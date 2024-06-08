import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/auth/register_page.dart';
import 'package:konekto/widgets/form/login_form_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        theme: const CupertinoThemeData(brightness: Brightness.light),
        home: const Login(),
        builder: EasyLoading.init());
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
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/auth_background.png"),
              fit: BoxFit.cover)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const LoginForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: 'New to Konekto? ',
                    style: TextStyle(
                        color: CupertinoColors.inactiveGray,
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
                                  builder: (context) => const Register()));
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
