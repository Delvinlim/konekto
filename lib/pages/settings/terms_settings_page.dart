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
                        'By downloading, installing, or using the Konekto mobile application ("App"), you agree to be bound by these Terms and Policies ("Terms"). If you do not agree with any of these Terms, you are prohibited from using the App.',
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
                        'You must be at least 13 years old to use Konekto. By using the App, you represent and warrant that you have the legal capacity to enter into this agreement and comply with these Terms. If you are under 18, you may use the App only with the consent and supervision of a parent or guardian.',
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
                        'Treat all users with respect, avoiding harassment, bullying, and hate speech. Do not post content that is illegal or violates any laws or regulations. Avoid spamming the community with repetitive or irrelevant messages, and ensure your posts and interactions are meaningful and contribute to the community.',
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
                        'You retain ownership of the content you create and share on Konekto. However, by posting, you grant Konekto a non-exclusive, royalty-free, worldwide, transferable license to use, display, and distribute your content. You are solely responsible for the content you post, and Konekto does not endorse any content and is not liable for any actions arising from your content.',
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
                        'We collect personal data that you provide during registration and use of the App. This includes, but is not limited to, your name, email address, and community activities. Your data is used to improve your experience on Konekto, including personalized content and communication. We do not sell your personal data to third parties, but we may share your data with trusted partners who assist us in operating the App. We implement security measures to protect your data, though we cannot guarantee absolute security.',
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
                        'All content provided by Konekto, including text, graphics, logos, and software, is the property of Konekto and protected by intellectual property laws. Konekto grants you a limited, non-exclusive, non-transferable license to use the App for personal, non-commercial purposes.',
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
                        'You may terminate your account at any time by following the instructions in the App. We reserve the right to suspend or terminate your access to the App if you violate these Terms or engage in any activity that disrupts or damages the App.',
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
                        'Konekto reserves the right to modify these Terms at any time. We will notify you of any changes by updating the Terms on our website and App. Your continued use of the App after such changes constitutes your acceptance of the new Terms.',
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
                        'These Terms are governed by and construed in accordance with the laws of Indonesia, without regard to its conflict of law principles. Any disputes arising under or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts located in Indonesia.',
                      ),
                    ),
                  ],
                ))));
  }
}
