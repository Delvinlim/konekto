import 'package:flutter/cupertino.dart';
import 'package:custom_accordion/custom_accordion.dart';
import 'package:flutter/material.dart';

class TermsSettingPage extends StatefulWidget {
  const TermsSettingPage({super.key});

  @override
  State<TermsSettingPage> createState() => _TermsSettingState();
}

class _TermsSettingState extends State<TermsSettingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Term & Policies'),
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(context),
            },
          ),
        ),
        child: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  children: [
                    CustomAccordion(
                      title: 'Acceptance of Terms',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'User Eligibility',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'Community Guidelines',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'User-Generated Content',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'Privacy and Data',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'Intellectual Property',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'Termination',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'Disclaimer of Warranties',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'Limitation of Liability',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'Changes to Terms',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                    CustomAccordion(
                      title: 'Governing Law',
                      headerBackgroundColor: CupertinoColors.white,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                      toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                      toggleIconClose: Icons.keyboard_arrow_up_sharp,
                      headerIconColor: CupertinoColors.black,
                      accordionElevation: 2,
                      widgetItems: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisi id quam finibus, sit amet cursus nunc ultrices.',
                      ),
                    ),
                  ],
                ))));
  }
}
