// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:health_care_app/appointments/appointment_container.dart';
import 'package:health_care_app/notifications/notification_service.dart';
import 'package:health_care_app/widgets/popup_window.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationContainer extends StatefulWidget {
  final Map notificationMap;
  const NotificationContainer({super.key, required this.notificationMap});

  @override
  State<NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {
  final notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          IconTheme(
              data: IconTheme.of(context)
                  .copyWith(color: Theme.of(context).focusColor),
              child: SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  icon: Icons.delete,
                  label: "Delete",
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopupWindow(
                          title: "Delete notification",
                          message:
                              "Do you really want to delete this notification?",
                          onPressed: () async {
                            // this deletes sending notification
                            await notificationService.cancelOneNotification(
                                widget.notificationMap['channelId']);

                            //TODO: usuwanie appointment
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  })),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(249, 243, 246, 254),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.notificationMap['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              ContainerRow(
                  title: DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(widget.notificationMap['scheduledDate'])),
                  iconData: Icons.calendar_today,
                  textMaxLines: 1),
              ContainerRow(
                  title: DateFormat('h:mm a').format(
                      DateTime.parse(widget.notificationMap['scheduledDate'])),
                  iconData: MdiIcons.clock,
                  iconSize: 20,
                  textMaxLines: 1),
            ],
          ),
        ),
      ),
    );
  }
}
