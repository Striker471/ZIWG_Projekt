import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final DateTime appDate;
  final String appType;
  final String appName;
  final String appLocation;
  final String? appPurpose;
 
  Appointment({
    required this.appDate,
    required this.appType,
    required this.appName,
    required this.appLocation,
    this.appPurpose
  });

  Map<String, dynamic> toMap(){
    return {
      'appDate' : Timestamp.fromDate(appDate),
      'appType' : appType,
      'appName' : appName,
      'appLocation' : appLocation,
      'appPurpose' : appPurpose
    };
  }
}
