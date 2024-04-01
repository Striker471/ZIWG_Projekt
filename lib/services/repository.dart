import 'package:health_care_app/model/appointment.dart';

abstract class Repository{
  Future<List<Appointment>> getAppointments();
  Future addAppointment(Appointment appointment);
}