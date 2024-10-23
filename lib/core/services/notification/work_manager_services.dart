import 'package:workmanager/workmanager.dart';

import 'notification_service.dart';

class WorkManagerServices {
  Future<void> init() async {
    await Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
    //startAction();
  }

  // startAction() async {
  //   Workmanager().registerPeriodicTask(
  //     "task1",
  //     "Task1name",
  //   );
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();
  //   await flutterLocalNotificationsPlugin.initialize(
  //     const InitializationSettings(
  //       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  //     ),
  //   );
  //   // Initialize the notifications plugin in the background task
  //   WeatherModel? weatherModel;
  //   try {
  //     Either<Failure, WeatherModel> weatherResult =
  //         await WeatherService().getWeatherForCity("cairo");
  //
  //     weatherResult.fold(
  //       (failure) {
  //         print("failure");
  //       },
  //       (weather) async {
  //         weatherModel = weather;
  //         print("ff = ${weatherModel?.current?.temp}");
  //
  //         try {
  //           await LocalNotificationService.showDailyScheduledNotification(
  //               weatherModel!.current!.temp!);
  //         } on Exception catch (e) {
  //           print(e.toString());
  //         }
  //         print("Notification Sent");
  //       },
  //     );
  //   } catch (e) {
  //     print("exception $e");
  //   }
  // }
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask(
    (taskName, inputData) async {
      await LocalNotificationService.showDailyScheduledNotification();
      return Future.value(true);
    },
  );
}
