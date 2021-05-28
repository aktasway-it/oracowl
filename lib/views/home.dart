import 'package:astropills_tools/services/location.service.dart';
import 'package:flutter/material.dart';
import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherService _weatherService = WeatherService();
  LocationService _locationService = LocationService();
  late Color _backgroundColor;

  @override
  void initState() {
    _backgroundColor = _weatherService.weather.isDay
        ? ThemeColors.primaryColor
        : ThemeColors.blackColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _backgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          backgroundColor: ThemeColors.interactiveColor,
          child: Icon(Icons.refresh),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 0.0),
            child: SizedBox.expand(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(_weatherService.weather.location,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.textColor,
                          )),
                    ),
                    Text(
                      _locationService.locationAsString,
                        style: TextStyle(
                          fontSize: 16,
                          color: ThemeColors.secondaryColor,
                        )
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.terrain,
                          color: ThemeColors.primaryColorDark,
                        ),
                        Text(
                            '${_locationService.altitude}m',
                            style: TextStyle(
                              fontSize: 16,
                              color: ThemeColors.primaryColorDark,
                            )
                        ),
                      ],
                    ),
                    Image.network(_weatherService.weather.currentWeatherIcon),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(_weatherService.weather.currentWeatherText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.textColor,
                          )),
                    ),
                    SizedBox(height: 10),
                  ]),
            ),
          ),
        ));
  }
}
