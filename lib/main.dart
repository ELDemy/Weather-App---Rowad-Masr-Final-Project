import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/home_screen/CitySelectionPage.dart';
import 'views/home_screen/providers/CityProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CityProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        home: CitySelectionPage(),
      ),
    );
  }
}
