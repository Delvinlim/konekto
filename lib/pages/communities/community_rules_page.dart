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
                        'We are committed to fostering a positive and inclusive environment on Konekto. Always treat fellow users with respect and kindness. Harassment, bullying, hate speech, and any form of discrimination will not be tolerated. Engage in conversations with an open mind and be considerate of different perspectives and experiences.',
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
                        'Your safety and the safety of others is paramount. Do not share personal information such as your home address, phone number, or any other private details. Avoid posting content that could be harmful or threatening to yourself or others. Report any suspicious or harmful behavior to our support team immediately.',
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
                        "Contribute to the community by staying on topic. Make sure your posts and comments are relevant to the community activity or discussion at hand. Off-topic posts can disrupt the flow of conversation and dilute the community's focus. Use appropriate channels for different types of content and discussions.",
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
                        'Respect intellectual property rights and ensure that all content you share is your own original work or is appropriately credited to the original creator. Do not copy or reproduce content from other sources without permission. Plagiarism undermines the trust and integrity of our community.',
                      ),
                    ),
                  ],
                ))));
  }
}
