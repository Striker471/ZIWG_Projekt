// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:health_care_app/appointments/appointment_container.dart';
import 'package:health_care_app/appointments/appointment_form.dart';
import 'package:health_care_app/appointments/main_switch.dart';
import 'package:health_care_app/blank_scaffold.dart';
import 'package:health_care_app/services/repository.dart';
import 'package:health_care_app/services/repository_impl.dart';
import 'package:health_care_app/widgets/message.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MainAppointments extends StatefulWidget {
  const MainAppointments({super.key});

  @override
  State<MainAppointments> createState() => _MainAppointmentsState();
}

class _MainAppointmentsState extends State<MainAppointments> {
  bool isCalendarView = true;
  DateTime selectedDay = DateTime.now();
  DateTime today = DateTime.now();
  List selectedDayAppointments = [];
  List selectedAfterDayAppointments = [];
  Map groupedAfterDayAppointments = {};
  final Repository repository = RepositoryImpl();
  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    try {
      var loadedAppointments = await repository.getAppointments();
      setState(() {
        appointments = loadedAppointments
            .map((appointment) => appointment.toMap())
            .toList();
      });
    } catch (e) {
      displayErrorMotionToast('Failed to load appointment.', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlankScaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AppointmentForm()));
            if (result == true) await loadAppointments();
          },
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
                const SizedBox(height: 110),
                SizedBox(
                  width: size.width * 0.9,
                  child: MainSwitch(
                    current: isCalendarView,
                    firstTitle: 'CHANGE TO CALENDAR',
                    secondTitle: 'CHANGE TO LIST',
                    firstIconData: Icons.list,
                    secondIconData: Icons.calendar_month,
                    onChanged: (value) => setState(
                      () => isCalendarView = value,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                isCalendarView
                    ? buildCalendar(appointments)
                    : buildListView(appointments),
              ],
            ),
          ),
        ));
  }

  List mapAppointmentsToDay(List<dynamic> appointments, DateTime day) {
    return appointments.where((appointment) {
      DateTime appointmentDate = DateTime.parse(appointment['date']);
      return isSameDay(appointmentDate, day);
    }).toList();
  }

  List mapAppointmentsAfterDay(List<dynamic> appointments) {
    return appointments.where((appointment) {
      DateTime appointmentDate = DateTime.parse(appointment['date']);
      return appointmentDate.isAfter(today) ||
          isSameDay(appointmentDate, today);
    }).toList();
  }

  Map groupAppointmentsByDate(List<dynamic> appointments) {
    Map groupedAppointments = {};
    for (Map appointment in mapAppointmentsAfterDay(appointments)) {
      String appointmentDate = appointment['date'].split('T')[0];
      groupedAppointments.putIfAbsent(appointmentDate, () => []);
      groupedAppointments[appointmentDate]!.add(appointment);
    }

    return groupedAppointments;
  }

  List sortAppointmentsByDate(Map groupedAppointments) {
    return groupedAppointments.keys.toList()
      ..sort((a, b) => DateTime.parse(a).compareTo(DateTime.parse(b)));
  }

  Widget buildListView(List<dynamic> appointments) {
    groupedAfterDayAppointments =
        groupAppointmentsByDate(mapAppointmentsAfterDay(appointments));
    selectedAfterDayAppointments =
        sortAppointmentsByDate(groupedAfterDayAppointments);

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: selectedAfterDayAppointments.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                DateFormat('dd MMMM yyyy').format(
                    DateTime.parse(selectedAfterDayAppointments[index])),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            ...groupedAfterDayAppointments[selectedAfterDayAppointments[index]]!
                .map((appointment) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: AppointnentContainer(
                        appointmentMap: appointment,
                        repository : repository
                      ),
                    ))
                .toList(),
          ],
        );
      },
    );
  }

  Widget buildCalendar(List<dynamic> appointments) {
    selectedDayAppointments = mapAppointmentsToDay(appointments, selectedDay);
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        TableCalendar(
          locale: 'en_Us',
          focusedDay: selectedDay,
          firstDay: DateTime(DateTime.now().year - 10),
          lastDay: DateTime(DateTime.now().year + 10),
          eventLoader: (day) {
            return mapAppointmentsToDay(appointments, day);
          },
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          onDaySelected: (day, events) {
            setState(() {
              selectedDay = day;
              selectedDayAppointments = mapAppointmentsToDay(appointments, day);
            });
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableGestures: AvailableGestures.all,
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            todayDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 38, 174, 108),
                      shape: BoxShape.circle),
                  width: 8.0,
                  height: 8.0,
                );
              }
              return null;
            },
          ),
        ),
        ...selectedDayAppointments
            .map((appointment) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AppointnentContainer(appointmentMap: appointment, repository: repository),
                ))
            .toList()
      ],
    );
  }
}
