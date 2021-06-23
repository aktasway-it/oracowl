import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();

  factory LocationService() => _singleton;

  LocationService._internal();

  late Position _currentLocation;
  bool _manuallySet = false;

  Future<bool> fetchCurrentLocation() async {
    try {
      if (!this._manuallySet) {
        LocationPermission permission = await Geolocator.requestPermission();
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return false;
        }
        this._currentLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        print(this._currentLocation.toString());
      }
    } catch (ex) {
      return false;
    }
    return true;
  }

  Future<bool> hasPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission != LocationPermission.denied && permission != LocationPermission.deniedForever;
  }

  void openSettings() {
    Geolocator.openLocationSettings();
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

  void flushPosition() {
    this._manuallySet = false;
  }

  void createPositionFromLatLon(double lat, double lon) {
    this._currentLocation = new Position(
        longitude: lon,
        latitude: lat,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);

    this._manuallySet = true;
  }
}
