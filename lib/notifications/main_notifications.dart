import 'package:flutter/material.dart';
import 'package:health_care_app/blank_scaffold.dart';
import 'package:health_care_app/notifications/notification_container.dart';
import 'package:health_care_app/notifications/notification_form.dart';
import 'package:health_care_app/notifications/notification_service.dart';
import 'package:health_care_app/notifications/notifications_global.dart';

class MainNotifications extends StatefulWidget {
  const MainNotifications({super.key});

  @override
  State<MainNotifications> createState() => _MainNotificationsState();
}

class _MainNotificationsState extends State<MainNotifications> {
  DateTime today = DateTime.now();
  Map groupedNotification = {};

  @override
  void initState() {
    groupedNotification = groupNotificationsBySchedule(notifications);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlankScaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NotificationForm(),
          )),
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: NotificationSchedule.values.length,
                  itemBuilder: (context, index) {
                    var notificationsForSchedule = groupedNotification[
                        translateNotificationForGroup(
                            NotificationSchedule.values[index])];

                    if (notificationsForSchedule != null) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              translateNotificationSchedule(
                                  NotificationSchedule.values[index]),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          ...notificationsForSchedule
                              .map((notification) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: NotificationContainer(
                                      notificationMap: notification,
                                    ),
                                  ))
                              .toList(),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  Map groupNotificationsBySchedule(List notifications) {
    Map groupedBySchedule = {};

    for (var notification in notifications) {
      String schedule = notification['schedule'];
      if (!groupedBySchedule.containsKey(schedule)) {
        groupedBySchedule[schedule] = [];
      }
      groupedBySchedule[schedule]!.add(notification);
    }

    return groupedBySchedule;
  }
}
