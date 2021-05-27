import 'package:astropills_tools/services/location.service.dart';
import 'package:flutter/material.dart';
import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/moon.service.dart';
import 'package:astropills_tools/services/weather.service.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MoonService _moonService = MoonService();
  WeatherService _weatherService = WeatherService();
  LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[900],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
            child: Column(children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(_weatherService.weather.location,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.primaryColor,
                            )),
                        Text(
                          'FOO',
                          style: TextStyle(color: ThemeColors.secondaryColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Image.asset(
                        _moonService.getLunarPhaseImage()
                      )),
                  Expanded(
                      flex: 1,
                      child: Image.network(
                          _weatherService.weather.currentWeatherIcon))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
