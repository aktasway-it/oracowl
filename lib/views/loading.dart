import 'package:astropills_tools/services/location.service.dart';
import 'package:astropills_tools/services/moon.service.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Loading extends StatefulWidget {
  const Loading();

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  MoonService _moonService = MoonService();
  WeatherService _weatherService = WeatherService();
  LocationService _locationService = LocationService();

  void loadData() async {
    Position? location = await _locationService.getCurrentLocation();
    if (location == null) {
      return;
    }
    await _weatherService.loadForecast(location.latitude, location.longitude);
    if (_weatherService.isDataLoaded()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Loading...'
          ),
        )
      )
    );
  }
}
