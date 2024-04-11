import 'package:flutter/material.dart';
import 'package:konekto/pages/auth/login_page.dart';
import 'package:konekto/pages/home/onboarding_page.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:konekto/widgets/appbar/app_bar_widget.dart';

// void main() {
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that plugins are initialized

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // Check if onboarding has been completed before
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;

  // Determine which screen to show based on onboarding completion status
  Widget initialScreen =
      onboardingCompleted ? const LoginPage() : const OnboardingPage();

  runApp(initialScreen);
}
