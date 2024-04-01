import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final DateTime date;
  final String doctorType;
  final String doctorName;
  final String location;
  final String? purpose;

  Appointment(
      {required this.date,
      required this.doctorType,
      required this.doctorName,
      required this.location,
      this.purpose});

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'doctorType': doctorType,
      'doctorName': doctorName,
      'location': location,
      'purpose': purpose
    };
  }
}
