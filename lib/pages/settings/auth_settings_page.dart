import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4.0),
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey.shade400),
                        border: KonektoBorder.all(color: Colors.grey.shade400),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14.0),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4.0),
                    decoration: BoxDecoration(
                        border: KonektoBorder.all(color: Colors.grey.shade400),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14.0),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4.0),
                    decoration: BoxDecoration(
                        border: KonektoBorder.all(color: Colors.grey.shade400),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                        color: Colors.blue.shade600,
                        child: const Text('Change Password'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _showPasswordChangedDialog(context);
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
