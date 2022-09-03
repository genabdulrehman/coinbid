import 'dart:async';

import 'package:coinbid/screens/onBoarding/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../dashboard/home/widgets/addOpenAdsManager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => const WelcomeScreen()));
    });
  }

  bool _visible = false;
  // AppOpenAdManager appOpenAdManager = AppOpenAdManager();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () async {
      // appOpenAdManager.showAdIfAvailable();
      setState(() {
        _visible = true;
      });
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: Container(
          color: Colors.white,
          child: Center(
            child: Image.asset(
              'images/google.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
