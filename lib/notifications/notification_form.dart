import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_app/blank_scaffold.dart';
import 'package:health_care_app/global.dart';
import 'package:health_care_app/notifications/notification_picker.dart';
import 'package:health_care_app/notifications/notification_service.dart';
import 'package:health_care_app/widgets/date_and_time_picker.dart';
import 'package:health_care_app/widgets/simple_button.dart';
import 'package:health_care_app/widgets/text_input_form.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationForm extends StatefulWidget {
  const NotificationForm({super.key});

  @override
  State<NotificationForm> createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  final notificationService = NotificationService();
  final String timeZoneLocation = 'Europe/Warsaw';

  @override
  void initState() {
    super.initState();
    tz.setLocalLocation(tz.getLocation(timeZoneLocation));
    setCyclicNotifications();
  }

  setCyclicNotifications() async {
    DateTime n = DateTime.now();
    // if (user.notifications ?? false) {
    //   int id = 13;
    //   List<MyNotification> notif =
    //       await NotificationService().getNotifications(user.id!);
    //   for (MyNotification n in notif) {
    // await notificationService.scheduleMonthlyNotification(
    //     n.date!.day, n.date!.hour, n.date!.minute, n.name!, id);
    await notificationService.scheduleNotification(
        NotificationSchedule.everyDay, n.day, n.hour, n.minute, "Test", 1001);
    // id++;
    //   }
    // }
  }

  TextEditingController date = TextEditingController();
  TextEditingController name = TextEditingController();
  NotificationSchedule schedule = NotificationSchedule.everyDay;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlankScaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom == 0
                  ? size.height * 0.2
                  : 20),
          SvgPicture.asset(
            'assets/undraw_my_notifications_re_ehmk.svg',
            height: size.height * 0.25,
          ),
          const SizedBox(height: 10),
          const Text(
            'New Notification Form',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInputForm(
                width: size.width * 0.9 - 55,
                hint: "Date",
                controller: date,
              ),
              const SizedBox(width: 5),
              Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  boxShadow: boxShadow,
                ),
                child: IconButton(
                  onPressed: () async => await selectDateTime(context, date),
                  icon: const Icon(Icons.calendar_today),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          TextInputForm(
              width: size.width * 0.9, hint: 'Name', controller: name),
          const SizedBox(height: 5),
          SizedBox(
            width: size.width * 0.9,
            child: NotificationPicker(
                selectedValue: schedule,
                returnSchedule: (newSchedule) => setState(() {
                      schedule = newSchedule;
                    })),
          ),
          const SizedBox(height: 10),
          SimpleButton(
              title: 'Submit',
              textColor: Colors.black,
              onPressed: () {
                // TODO: Logika za dodaniem nowej notyfikacji. Jak się uda to pop
                // W tym momencie ustawiamy że się będzie wysyłać

                String appName = name.text;
                String appDate = date.text;
                schedule;

                Navigator.of(context).pop();
              }),
        ],
      ),
    ));
  }
}
