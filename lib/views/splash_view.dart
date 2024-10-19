import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/views/home_screen/CitySelectionPage.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';

class SplashView extends StatefulWidget {
  static const String routeName = "splash";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => CityProvider(),
              child: const CitySelectionPage(),
            ),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Image.asset(
        "assets/images/splash3.jpg",
        fit: BoxFit.cover,
        height: mediaQuery.height,
        width: mediaQuery.width,
      ),
    );
  }
}
