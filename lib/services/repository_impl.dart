import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care_app/model/appointment.dart';
import 'package:health_care_app/services/firebase_paths.dart';
import 'package:health_care_app/services/repository.dart';

class RepositoryImpl implements Repository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future addAppointment(Appointment appointment) async {
    await _firestore
        .collection(FirebasePaths.appointments)
        .add(appointment.toMap());
  }

  @override
  Future<List<Appointment>> getAppointments() {
    // TODO: implement getAppointments
    throw UnimplementedError();
  }
}
