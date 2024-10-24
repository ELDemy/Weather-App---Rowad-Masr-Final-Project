import 'package:workmanager/workmanager.dart';

import 'notification_service.dart';

class WorkManagerServices {
  Future<void> init() async {
    await Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
  }
}

//top level fun
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (taskName, inputData) async {
      await LocalNotificationService.showDailyScheduledNotification();
      return Future.value(true);
    },
  );
}
