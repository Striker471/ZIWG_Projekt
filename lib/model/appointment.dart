import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String? id;
  final String? userId;
  final DateTime date;
  final String doctorType;
  final String doctorName;
  final String location;
  final String? purpose;

  Appointment(
      {this.id,
      this.userId,
      required this.date,
      required this.doctorType,
      required this.doctorName,
      required this.location,
      this.purpose});

  factory Appointment.fromSnaphot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Appointment(
        id: snapshot.id,
        userId: data['userId'] as String?,
        date: (data['date'] as Timestamp).toDate(),
        doctorType: data['doctorType'] as String,
        doctorName: data['doctorName'] as String,
        location: data['location'] as String,
        purpose: data['purpose'] as String?);
  }

  Map<String, dynamic> toMap(String userId) {
    return {
      'userId': userId,
      'date': Timestamp.fromDate(date),
      'doctorType': doctorType,
      'doctorName': doctorName,
      'location': location,
      'purpose': purpose
    };
  }
}
