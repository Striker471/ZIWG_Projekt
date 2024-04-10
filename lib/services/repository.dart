import '../model/appointment.dart';
import '../model/notification.dart';

abstract class Repository {
  // appointment
  Future<void> addAppointment(Appointment appointment);
  Future<List<Appointment>> getAppointments();
  Future<void> deleteAppointment(String id);

  // notification
  Future<void> addNotification(Notification notification);
  Future<List<Notification>> getNotifications();
  Future<void> deleteNotification(String id);

  String getUserId();
}
