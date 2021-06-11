import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();

  factory LocationService() => _singleton;

  LocationService._internal();

  late Position _currentLocation;

  Future<bool> fetchCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      }
      this._currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(this._currentLocation.toString());
    } catch (ex) {
      return false;
    }
    return true;
  }

  Position get position {
    return _currentLocation;
  }

  String get locationAsString {
    if (_currentLocation == null) {
      return 'N/A';
    }
    return '${_currentLocation.latitude}, ${_currentLocation.longitude}';
  }

  int get altitude {
    if (_currentLocation == null) {
      return 0;
    }
    return _currentLocation.altitude.round();
  }
}
