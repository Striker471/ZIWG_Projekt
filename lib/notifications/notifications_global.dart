import 'package:health_care_app/notifications/notification_service.dart';

//FIXME: to be removed after firebase
List<Map<String, dynamic>> notifications = [
  {
    'date': '2024-04-03T10:45:00Z', //Starting date
    'name': 'Ibuprofen', //String
    'schedule': 'everyDay', //String
  },
  {
    'date': '2024-04-05T11:45:00Z',
    'name': 'Paracetamol',
    'schedule': 'everyTwoDays',
  },
];

translateNotificationSchedule(NotificationSchedule schedule) {
  switch (schedule) {
    case NotificationSchedule.everyDay:
      return 'Every day';
    case NotificationSchedule.everyTwoDays:
      return 'Every two days';
    case NotificationSchedule.everyThreeDays:
      return 'Every three days';
    case NotificationSchedule.everyFiveDays:
      return 'Every five days';
    case NotificationSchedule.everyWeek:
      return 'Every week';
    case NotificationSchedule.everyTwoWeeks:
      return 'Every two weeks';
    default:
      return 'Every day';
  }
}

translateNotificationForGroup(NotificationSchedule schedule) {
  switch (schedule) {
    case NotificationSchedule.everyDay:
      return 'everyDay';
    case NotificationSchedule.everyTwoDays:
      return 'everyTwoDays';
    case NotificationSchedule.everyThreeDays:
      return 'everyThreeDays';
    case NotificationSchedule.everyFiveDays:
      return 'everyFiveDays';
    case NotificationSchedule.everyWeek:
      return 'everyWeek';
    case NotificationSchedule.everyTwoWeeks:
      return 'everyTwoWeeks';
    default:
      return 'everyDay';
  }
}
