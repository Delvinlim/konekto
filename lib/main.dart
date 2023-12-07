import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konekto/pages/home/onboarding_page.dart';
import 'package:flutter/services.dart';
// import 'package:konekto/widgets/appbar/app_bar_widget.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() {
void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const OnboardingPage());
}
