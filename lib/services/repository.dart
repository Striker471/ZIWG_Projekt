import '../model/appointment.dart';
import '../model/notification.dart';

abstract class Repository {
  // appointment
  Future<void> addAppointment(Appointment appointment);
  Future<List<Appointment>> getAppointments();

  // notification
  Future<void> addNotification(Notification notification);
  Future<List<Notification>> getNotifications();

  String getUserId();
}
