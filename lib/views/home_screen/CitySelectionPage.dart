import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/services/notification/notification_service.dart';
import 'package:weather/core/utiles/constants.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';
import 'package:workmanager/workmanager.dart';

import '../../core/services/notification/work_manager_services.dart';
import 'widgets/dismissible_card.dart';
import 'widgets/live_weather_card.dart';
import 'widgets/search_text_field.dart';

class CitySelectionPage extends StatefulWidget {
  static const String routeName = "CitySelectionPage";
  const CitySelectionPage({super.key});

  @override
  State<CitySelectionPage> createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar(context),
      body: Column(
        children: [
          const SearchCityTextField(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount:
                  Provider.of<CityProvider>(context).selectedCities.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return LiveWeatherCard(index: index);
                } else {
                  return DismissibleCard(index: index - 1);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leadingWidth: 80,
      leading: changeTempIcon(),
      actions: [
        refreshIcon(context),
        IconButton(
            onPressed: () async {
              await WorkManagerServices().init();
              Workmanager().registerPeriodicTask(
                'daily_notification_task',
                'show_daily_notification',
                frequency: const Duration(minutes: 15),
                initialDelay: const Duration(seconds: 10), // Adjust for testing
              );
            },
            icon: const Icon(
              Icons.notification_add,
              color: Colors.red,
            )),
        IconButton(
            onPressed: () async {
              await Workmanager().cancelAll();
              LocalNotificationService.cancelNotification(0);
            },
            icon: const Icon(Icons.cancel))
      ],
      title: const Text(
        'Weather App',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  IconButton refreshIcon(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      onPressed: () {
        Provider.of<CityProvider>(context, listen: false)
            .fetchUserCity(context);
        setState(() {});
      },
      icon: const Icon(Icons.refresh),
      color: Colors.white,
    );
  }

  Widget changeTempIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        radius: 24,
        onTap: () {
          Temp.tempType == TempType.C
              ? Temp.tempType = TempType.F
              : Temp.tempType = TempType.C;
          setState(() {});
        },
        child: Row(
          children: [
            const Icon(Icons.thermostat, color: Colors.white),
            Text(
              Temp.tempText,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
