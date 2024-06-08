import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  void launchWhatsapp(String message, String phone) async {
    String queryMessage = Uri.encodeComponent(message);
    String queryPhone = Uri.encodeComponent(phone);
    // String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    String whatsappUrl =
        "https://api.whatsapp.com/send/?phone=$queryPhone&text=$queryMessage&type=phone_number&app_absent=0";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    }
  }

  void _forgotPassword() async {
    toastification.show(
        context: context,
        title: const Text("Success"),
        description: const Text(
          'You will receive an email to reset your password.',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        alignment: Alignment.topCenter,
        direction: TextDirection.ltr,
        dragToClose: true,
        showProgressBar: false,
        callbacks: ToastificationCallbacks(
            onAutoCompleteCompleted: (toastItem) => Navigator.pop(context)));
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
              'Please enter your email address to search for your account.',
              style: TextStyle(color: CupertinoColors.black, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 60,
            child: CupertinoTextFormFieldRow(
              placeholder: 'Enter email address',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              controller: emailController,
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
          Center(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                  color: Colors.blue.shade600,
                  child: const Text('Search'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // _forgotPassword();
                      launchWhatsapp(
                          'Hi Konekto, saya mau reset password saya dengan email berikut: ${emailController.text}',
                          '+6282288521900');
                    }
                  }),
            ),
          ))
        ],
      ),
    );
  }
}
