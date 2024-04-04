import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

enum NotificationSchedule {
  everyDay,
  everyTwoDays,
  everyThreeDays,
  everyFiveDays,
  everyWeek,
  everyTwoWeeks,
}

class NotificationConstants {
  static const String channelID = '6526d64c2c8db4930827e46a';
  static const String channelName = 'healthCareApp';
  static const String channelDescription = 'healthCareAppNotif';
}

const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
  NotificationConstants.channelID,
  NotificationConstants.channelName,
  channelDescription: NotificationConstants.channelDescription,
  importance: Importance.max,
  priority: Priority.high,
);

class NotificationService {
  static final NotificationService _singleton = NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _singleton;
  }

  // initialize notification
  NotificationService._internal() {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    //TODO: IOS
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
            NotificationConstants.channelID,
            NotificationConstants.channelName,
            description: NotificationConstants.channelDescription,
            importance: Importance.high,
          ));
    }
  }

  // Schedule notifications
  scheduleNotification(NotificationSchedule schedule, int day, int hour,
      int minute, String name, int id) async {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate;

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    int daysToAdd = scheduleNotificationProperly(schedule);

    scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day + daysToAdd, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = tz.TZDateTime(
          tz.local, now.year, now.month, now.day + daysToAdd + 1, hour, minute);
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Przypomnenie o lekach!',
        'Pamiętaj o wzięciu leku $name.',
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
  }

  // Show nofication now (usually triggered by sth)
  Future showNotification(
      {required String title, required String body, int id = 0}) async {
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
  }
}

scheduleNotificationProperly(NotificationSchedule schedule) {
  switch (schedule) {
    case NotificationSchedule.everyDay:
      return 1;
    case NotificationSchedule.everyTwoDays:
      return 2;
    case NotificationSchedule.everyThreeDays:
      return 3;
    case NotificationSchedule.everyFiveDays:
      return 5;
    case NotificationSchedule.everyWeek:
      return 7;
    case NotificationSchedule.everyTwoWeeks:
      return 14;
    default:
      return 1;
  }
}
