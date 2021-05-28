import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();
  factory LocationService() => _singleton;
  LocationService._internal();

  Position? _currentLocation;

  Future<Position?> fetchCurrentLocation() async {
    if (this._currentLocation == null) {
      LocationPermission permission = await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return null;
      }
      this._currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      print(this._currentLocation.toString());
    }
    return _currentLocation;
  }

  String get locationAsString {
    if (_currentLocation == null) {
      return 'N/A';
    }
    return '${_currentLocation!.latitude}, ${_currentLocation!.longitude}';
  }

  int get altitude {
    if (_currentLocation == null) {
      return 0;
    }
    return _currentLocation!.altitude.round();
  }
}