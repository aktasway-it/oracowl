import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();
  factory LocationService() => _singleton;
  LocationService._internal();

  bool _locationAvailable = false;

  Future<Position?> getCurrentLocation() async {
    if (!_locationAvailable) {
      LocationPermission permission = await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return null;
      }
      Position location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      print(location.toString());
      return location;
    }
  }
}