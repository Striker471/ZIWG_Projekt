import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_app/model/appointment.dart';
import 'package:health_care_app/model/notification.dart';
import 'package:health_care_app/services/firebase_paths.dart';
import 'package:health_care_app/services/repository.dart';

class RepositoryImpl implements Repository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> addAppointment(Appointment appointment) async {
    await _firestore
        .collection(FirebasePaths.appointments)
        .add(appointment.toDTOMap(getUserId()));
  }

  @override
  Future<List<Appointment>> getAppointments() async {
    var querySnapshot = await _firestore
        .collection(FirebasePaths.appointments)
        .where("userId", isEqualTo: getUserId())
        .get();
    return querySnapshot.docs
        .map((doc) => Appointment.fromSnaphot(doc))
        .toList();
  }

  @override
  Future<void> addNotification(Notification notification) async {
    await _firestore
        .collection(FirebasePaths.notifications)
        .add(notification.toDTOMap(getUserId()));
  }

  @override
  Future<List<Notification>> getNotifications() async {
    var querySnapshot = await _firestore
        .collection(FirebasePaths.notifications)
        .where("userId", isEqualTo: getUserId())
        .get();
    return querySnapshot.docs
        .map((doc) => Notification.fromSnaphot(doc))
        .toList();
  }

  @override
  String getUserId() {
    return _firebaseAuth.currentUser?.uid ??
        (throw Exception("Null Firebase User"));
  }
}
