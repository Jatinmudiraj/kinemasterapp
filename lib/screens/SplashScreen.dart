import 'package:flutter/material.dart';
import 'package:kindmaster/screens/MainScreen.dart';
import 'package:splashscreen/splashscreen.dart';
 class LoadingScreen extends StatelessWidget {
  const LoadingScreen({key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
  seconds: 4,
  navigateAfterSeconds: const MainPage(),
  title: const Text('Welcome In SplashScreen'),
  image: Image.asset('assets/img.png'),
  backgroundColor: const Color.fromARGB(242, 253, 77, 61),
  styleTextUnderTheLoader: const TextStyle(),
  photoSize: 100.0,
  loaderColor: Colors.red
);
  }
}