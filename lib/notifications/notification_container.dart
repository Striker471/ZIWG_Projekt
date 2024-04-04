import 'package:flutter/material.dart';
import 'package:health_care_app/appointments/appointment_container.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationContainer extends StatelessWidget {
  final Map notificationMap;
  const NotificationContainer({super.key, required this.notificationMap});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              notificationMap['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            ContainerRow(
                title: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(notificationMap['date'])),
                iconData: Icons.calendar_today,
                textMaxLines: 1),
            ContainerRow(
                title: DateFormat('h:mm a')
                    .format(DateTime.parse(notificationMap['date'])),
                iconData: MdiIcons.clock,
                iconSize: 20,
                textMaxLines: 1),
          ],
        ),
      ),
    );
  }
}
