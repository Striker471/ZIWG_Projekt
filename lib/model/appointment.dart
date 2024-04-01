class Appointment{
  final String appType;
  final String appName;
  final String appLocation;
  final String? appPurpose;
 
  Appointment({
    required this.appType,
    required this.appName,
    required this.appLocation,
    this.appPurpose
  });

  
}
