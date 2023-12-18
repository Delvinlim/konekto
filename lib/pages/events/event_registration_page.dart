import 'package:flutter/cupertino.dart';
import 'package:konekto/widgets/form/event_registration_form_widget.dart';

class EventRegistrationPage extends StatefulWidget {
  const EventRegistrationPage({super.key});

  @override
  State<EventRegistrationPage> createState() => _EventRegistrationState();
}

class _EventRegistrationState extends State<EventRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Registration'),
          backgroundColor: CupertinoColors.white,
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => Navigator.of(context).pop(context),
          ),
        ),
        child: const SafeArea(child: EventRegistrationForm()));
  }
}
