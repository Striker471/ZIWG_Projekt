import 'package:location/location.dart';

Future initializeLocation() async {
  final Location location = Location();
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  LocationData? locationData;

  serviceEnabled = await location.serviceEnabled();
  print('Usługa lokalizacji jest włączona: $serviceEnabled');
  if (!serviceEnabled) {
    print('Poprawnie zażądano włączenia usługi lokalizacji: $serviceEnabled');
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  print('Dostęp do lokalizacji: $permissionGranted');
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    print('Poprawnie zażądano dostępu do lokalizacji: $permissionGranted');
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
  locationData = await location.getLocation();
  print(locationData.latitude.toString());
  print(
      'Aktualna lokalizacja: ${locationData.latitude}, ${locationData.longitude}');

  return locationData;
}
