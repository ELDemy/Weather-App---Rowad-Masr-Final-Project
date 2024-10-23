import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/services/notification/notification_service.dart';
import 'package:weather/views/splash_view.dart';

import 'views/home_screen/providers/CityProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();

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
        home: SplashView(),
      ),
    );
  }
}
