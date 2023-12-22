import 'package:flutter/cupertino.dart';
import 'package:custom_accordion/custom_accordion.dart';
import 'package:flutter/material.dart';

class CommunityRulesPage extends StatefulWidget {
  const CommunityRulesPage({super.key});

  @override
  State<CommunityRulesPage> createState() => _CommunityRulesState();
}

class _CommunityRulesState extends State<CommunityRulesPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        // Uncomment to change the background color
        // backgroundColor: CupertinoColors.systemPink,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Community Rules'),
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
                      title: 'Respect & Kindness',
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
                      title: 'Keep it Safe',
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
                      title: 'Stay On-Topic',
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
                      title: 'No Plagiarism',
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
