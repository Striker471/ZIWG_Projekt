abstract class Repository{
  Future<List<Appointment>> getAppointments();
  Future<void> addAppointment(Appointment appointment);
}