import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/location.service.dart';
import 'package:astropills_tools/services/oracowl.service.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading();

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  OracowlService _oracowlService = OracowlService();
  WeatherService _weatherService = WeatherService();
  LocationService _locationService = LocationService();

  void loadData() async {
    Position? location =
        await _locationService.fetchCurrentLocation(forceReload: true);
    if (location == null) {
      return;
    }
    await _oracowlService.loadData(location.latitude, location.longitude,
        forceReload: true);
    await _weatherService.loadForecast(location.latitude, location.longitude,
        forceReload: true);
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
        backgroundColor: ThemeColors.primaryColorDark,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/oracowl.png'),
                Text(
                  'ORACOWL',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.textColor
                  )
                ),
                SpinKitRipple(
                  color: ThemeColors.textColor,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ));
  }
}
