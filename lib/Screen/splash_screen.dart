import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:makan_makan/Screen/page/home.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    openSplashScreen();
  }

  openSplashScreen() async {
    var duration = const Duration(seconds: 5);

    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow.shade700,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/splash_screen.json'),
              const Text(
                "FoodMarket",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ));
  }
}
