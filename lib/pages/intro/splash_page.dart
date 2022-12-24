// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:itmobile/main.dart';
import 'package:lottie/lottie.dart';
class SplashPage extends StatefulWidget {
  static const String id='ll';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.scaleTransition,
      //pageTransitionType: PageTransitionType.fade,
      splash:Lottie.asset('assets/jsons/108285-online-learning-platform.json'),
      nextScreen: const Main(),
      backgroundColor:ColorClass().mainColor(),
      duration: 1000,
      splashIconSize: 500,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
