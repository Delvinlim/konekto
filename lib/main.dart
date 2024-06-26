import 'package:flutter/material.dart';
import 'package:konekto/pages/auth/login_page.dart';
import 'package:konekto/pages/home/onboarding_page.dart';
import 'package:flutter/services.dart';
import 'package:konekto/widgets/appbar/app_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() {
void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..indicatorSize = 45.0
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.transparent
    ..backgroundColor = Colors.transparent
    ..boxShadow = []
    ..userInteractions = true
    ..dismissOnTap = false;
}

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that plugins are initialized

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // Check if onboarding has been completed before
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOnboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;

  late bool isExpired;
  try {
    isExpired = await FlutterSessionJwt.isTokenExpired();
  } catch (e) {
    isExpired = true;
  }

  // Determine which screen to show based on onboarding completion status
  Widget initialScreen = isOnboardingCompleted
      ? isExpired
          ? const LoginPage()
          : const MainBarPage()
      : const OnboardingPage();

  runApp(initialScreen);
  configLoading();
}
