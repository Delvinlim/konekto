import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/utils/konekto_border.dart';

class EventRegistrationForm extends StatefulWidget {
  const EventRegistrationForm({super.key});

  @override
  State<EventRegistrationForm> createState() => _EventRegistrationFormState();
}

// This shows a CupertinoModalPopup which hosts a CupertinoAlertDialog.
void _showAlertDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Completed'),
      content: const Text(
          'Thank you for registering, we will contact you as soon as possible'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            // Navigator.of(context, rootNavigator: true).pushReplacement(
            //     CupertinoPageRoute(builder: (context) => const HomePage()));

            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                    child: Text('Team Name',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 80,
                    child: CupertinoTextFormFieldRow(
                      placeholder: 'Enter your team name',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey.shade400),
                          border:
                              KonektoBorder.all(color: Colors.grey.shade400),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your team name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                    child: Text('Leader Name',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 80,
                    child: CupertinoTextFormFieldRow(
                      placeholder: 'Enter your leader name',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          border:
                              KonektoBorder.all(color: Colors.grey.shade400),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your leader name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                    child: Text('Leader Email',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 80,
                    child: CupertinoTextFormFieldRow(
                      placeholder: 'Enter your leader email',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey.shade400),
                          border:
                              KonektoBorder.all(color: Colors.grey.shade400),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your leader email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                    child: Text('Leader Phone',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 80,
                    child: CupertinoTextFormFieldRow(
                      placeholder: 'Enter your leader phone',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          border:
                              KonektoBorder.all(color: Colors.grey.shade400),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your leader phone';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                    child: Text('Player',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 80,
                    child: CupertinoTextFormFieldRow(
                      placeholder: 'Enter your player',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey.shade400),
                          border:
                              KonektoBorder.all(color: Colors.grey.shade400),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your player';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                    child: Text('Team Base',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 80,
                    child: CupertinoTextFormFieldRow(
                      placeholder: 'Enter your team base',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          border:
                              KonektoBorder.all(color: Colors.grey.shade400),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your team base';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
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
                    child: const Text('Register Now'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showAlertDialog(context);
                      }
                    }),
              ),
            ))
          ],
        ));
  }
}
