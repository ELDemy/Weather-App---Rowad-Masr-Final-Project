import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/services/notification/notification_service.dart';
import 'package:weather/views/home_screen/CitySelectionPage.dart';
import 'package:workmanager/workmanager.dart';

import 'core/services/notification/work_manager_services.dart';
import 'views/home_screen/providers/CityProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WeatherApp());
  initNotification();
}

Future<void> initNotification() async {
  await LocalNotificationService.init();
  await WorkManagerServices().init();
  Workmanager().registerPeriodicTask(
    'daily_notification_task',
    'show_daily_notification',
    frequency: const Duration(hours: 6),
    initialDelay: const Duration(seconds: 10), // Adjust for testing
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: ChangeNotifierProvider(
        create: (context) => CityProvider(),
        child: const CitySelectionPage(),
      ),
    );
  }
}
