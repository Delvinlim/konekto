import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:konekto/pages/auth/login_page.dart';

/// Flutter code sample for [CupertinoPageScaffold].

// void main() => runApp(const OnboardingPage());

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: OnBoarding(),
    );
  }
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return CupertinoOnboarding(
      // color: Colors.white,
      bottomButtonColor: Colors.lightBlue,
      onPressedOnLastPage: () => Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => const Login())),
      // onPressedOnLastPage: () => Navigator.of(context).pushNamedAndRemoveUntil(CupertinoPageRoute(builder: (context) => const KonektoTabBar()), (route) => false),

      bottomButtonChild: const Text(
        'Continue',
        style: TextStyle(color: Colors.white),
      ),
      pages: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/images/onboarding_1.png'),
                ],
              ),

              // const SizedBox(height: 60.0),
              const Center(
                child: Text(
                  'Discover',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const Center(
                child: Text(
                  'New Activities',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: 14.0),
              const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Center(
                    child: Text(
                      'Fostering meaningful relationships with individuals who have similar interests',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  )),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/images/onboarding_2.png'),
                ],
              ),

              // const SizedBox(height: 60.0),
              const Center(
                child: Text(
                  'Endless Fun and',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const Center(
                child: Text(
                  'Entertainment',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: 14.0),
              const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Center(
                    child: Text(
                      'Dive into a world of endless fun and entertainment with a diverse range of activities',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  )),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/images/onboarding_3.png'),
                ],
              ),

              // const SizedBox(height: 60.0),
              const Center(
                child: Text(
                  'Laugh and Share',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const Center(
                child: Text(
                  'Moments',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: 14.0),
              const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Center(
                    child: Text(
                      'Fostering meaningful relationships with individuals who have similar interests',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
