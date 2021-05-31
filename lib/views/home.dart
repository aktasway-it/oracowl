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
                    Text(_locationService.locationAsString,
                        style: TextStyle(
                          fontSize: 16,
                          color: ThemeColors.secondaryColor,
                        )),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.terrain,
                          color: ThemeColors.primaryColorDark,
                        ),
                        Text('${_locationService.altitude}m',
                            style: TextStyle(
                              fontSize: 16,
                              color: ThemeColors.primaryColorDark,
                            )),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forecast');
                      },
                      child: Image.network(_weatherService.weather.currentWeatherIcon)
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(_weatherService.weather.currentWeatherText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.textColor,
                          )),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Image.asset(_weatherService
                                    .weather.astronomy['moon_icon']),
                                SizedBox(width: 5),
                                Column(
                                  children: [
                                    Text(
                                      '${_weatherService.weather.astronomy['moon_phase']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ThemeColors.textColor,
                                      ),
                                    ),
                                    Text(
                                      'Illuminazione: ${_weatherService.weather.astronomy['moon_illumination']}%',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ThemeColors.textColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _weatherService
                                              .weather.astronomy['moonrise'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ThemeColors.secondaryColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.upgrade,
                                          color: ThemeColors.secondaryColor,
                                          size: 18,
                                        ),
                                        Icon(
                                          Icons.vertical_align_bottom,
                                          color: ThemeColors.primaryColorDark,
                                          size: 18,
                                        ),
                                        Text(
                                          _weatherService
                                              .weather.astronomy['moonset'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ThemeColors.primaryColorDark,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.nights_stay,
                                  color: ThemeColors.textColor,
                                  size: 35,
                                ),
                                SizedBox(width: 5),
                                Column(
                                  children: [
                                    Text(
                                      'Min: ${_weatherService.weather.today['mintemp_c']}° - Max: ${_weatherService.weather.today['maxtemp_c']}°',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ThemeColors.textColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${_weatherService.weather.today['totalprecip_mm']} mm (${_weatherService.weather.today['daily_chance_of_rain']}%)',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ThemeColors.secondaryColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.umbrella,
                                          color: ThemeColors.secondaryColor,
                                          size: 18,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.air,
                                          color: ThemeColors.primaryColorDark,
                                          size: 18,
                                        ),
                                        Text(
                                          '${_weatherService.weather.today['maxwind_kph']} km/h',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ThemeColors.primaryColorDark,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _weatherService
                                              .weather.astronomy['sunrise'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ThemeColors.secondaryColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.wb_sunny,
                                          color: ThemeColors.secondaryColor,
                                          size: 18,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.nightlight_round,
                                          color: ThemeColors.primaryColorDark,
                                          size: 18,
                                        ),
                                        Text(
                                          _weatherService
                                              .weather.astronomy['sunset'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ThemeColors.primaryColorDark,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }
}
