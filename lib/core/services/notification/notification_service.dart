import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../models/weather_model/WeatherModel.dart';
import '../errors/failure_class.dart';
import '../weather_api/weather_services.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {}

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  //showDailyScheduledNotification
  static Future<void> showDailyScheduledNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'daily Scheduled notification',
      'id 4',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var currentTime = tz.TZDateTime.now(tz.local);
    WeatherModel? weatherModel;
    try {
      Either<Failure, WeatherModel> weatherResult =
          await WeatherService().getWeatherForCity("cairo");

      weatherResult.fold(
        (failure) {
          debugPrint("failure");
        },
        (weather) async {
          weatherModel = weather;
          debugPrint("Weather = ${weatherModel?.current?.temp}");
        },
      );
    } catch (e) {
      debugPrint("exception $e");
    }

    var scheduleTime = tz.TZDateTime(
      tz.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      7,
    );
    debugPrint("${scheduleTime.hour}");
    debugPrint("${scheduleTime.minute}");
    debugPrint("${scheduleTime.second}");

    if (scheduleTime.isBefore(currentTime)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
    }
    if (weatherModel == null) {
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Daily Weather Notification',
        DateTime.now().hour > 7
            ? 'Your Weather is ${weatherModel?.forecast?.forecastday?[1].day?.maxTemp}'
            : 'Your Weather is ${weatherModel?.current?.tempC}',
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        scheduleTime,
        details,
        payload: 'zonedSchedule',
        androidScheduleMode: AndroidScheduleMode.exact,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
