import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppointnentContainer extends StatelessWidget {
  final Map appointmentMap;
  const AppointnentContainer({super.key, required this.appointmentMap});

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
              appointmentMap['doctorType'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            ContainerRow(
                title: appointmentMap['doctorName'],
                iconData: Icons.person,
                textMaxLines: 1),
            ContainerRow(
                title: DateFormat('h:mm a')
                    .format(DateTime.parse(appointmentMap['date'])),
                iconData: MdiIcons.clock,
                iconSize: 20,
                textMaxLines: 1),
            ContainerRow(
                title: appointmentMap['location'],
                iconData: Icons.location_pin),
            appointmentMap.containsKey('purpose') &&
                    appointmentMap['purpose'] != ""
                ? Row(
                    children: [
                      Center(
                        child: Icon(Icons.description,
                            size: 20, color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(width: 5),
                      Expanded(child: Text(appointmentMap['purpose'])),
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class ContainerRow extends StatelessWidget {
  final String title;
  final IconData iconData;
  final double iconSize;
  final int textMaxLines;
  const ContainerRow(
      {super.key,
      required this.title,
      required this.iconData,
      this.iconSize = 22,
      this.textMaxLines = 2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Icon(iconData,
              size: iconSize, color: Theme.of(context).primaryColor),
        ),
        if (textMaxLines != 2) const SizedBox(width: 5),
        Expanded(
          child: Text(
            title,
            maxLines: textMaxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
