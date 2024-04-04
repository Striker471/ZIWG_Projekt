import 'package:health_care_app/model/appointment.dart';

abstract class Repository {
  Future<void> addAppointment(Appointment appointment);
  Future<List<Appointment>> getAppointments();
  String getUserId();
}
