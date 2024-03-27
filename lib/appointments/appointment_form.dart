import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_app/blank_scaffold.dart';
import 'package:health_care_app/global.dart';
import 'package:health_care_app/widgets/date_and_time_picker.dart';
import 'package:health_care_app/widgets/simple_button.dart';
import 'package:health_care_app/widgets/text_input_form.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({super.key});

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  TextEditingController date = TextEditingController();
  TextEditingController doctorType = TextEditingController();
  TextEditingController doctorName = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController purpose = TextEditingController();

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
            'assets/undraw_events_re_98ue.svg',
            height: size.height * 0.25,
          ),
          const SizedBox(height: 10),
          const Text(
            'New Appointment Form',
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
              width: size.width * 0.9,
              hint: 'Doctor Type',
              controller: doctorType),
          const SizedBox(height: 5),
          TextInputForm(
              width: size.width * 0.9,
              hint: 'Doctor Name',
              controller: doctorName),
          const SizedBox(height: 5),
          TextInputForm(
              width: size.width * 0.9, hint: 'Location', controller: location),
          const SizedBox(height: 5),
          TextInputForm(
              width: size.width * 0.9, hint: 'Purpose', controller: purpose),
          const SizedBox(height: 10),
          SimpleButton(
              title: 'Submit',
              textColor: Colors.black,
              onPressed: () {
                // TODO: Logika za dodaniem nowego spotakania. Jak się uda to pop
                // Zakładamy że purpose nie jest wymagany!

                String appType = doctorType.text;
                String appName = doctorName.text;
                String appLocation = location.text;
                String appPurpose = purpose.text;

                Navigator.of(context).pop();
              }),
        ],
      ),
    ));
  }
}
