import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Text('Username',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 60,
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your username',
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 60,
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your email',
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 60,
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your password',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 60,
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter your password',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                  border: KonektoBorder.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
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
                  child: const Text('Sign In'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  }),
            ),
          ))
        ],
      ),
    );
  }
}
