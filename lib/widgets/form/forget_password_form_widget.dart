import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
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
            child: Text(
              'Find Your Account',
              style: TextStyle(
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Text(
              'Please enter your email address or mobile number to search for your account.',
              style: TextStyle(color: CupertinoColors.black, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 60,
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter email address or username',
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
          Center(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                  color: Colors.blue.shade600,
                  child: const Text('Search'),
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
