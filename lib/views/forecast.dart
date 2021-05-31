import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:flutter/material.dart';

class Forecast extends StatefulWidget {
  const Forecast();

  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  WeatherService _weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${_weatherService.weather.location}'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: _weatherService.weather.forecastHourly.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                      _weatherService.weather.forecastHourly[index]['time'],
                    style: TextStyle(
                      fontSize: 14,
                      color: ThemeColors.blackColorDark,
                    ),
                  ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_weatherService.weather.forecastHourly[index]
                        ['condition']['text']),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.umbrella,
                              color: ThemeColors.secondaryColorDark,
                              size: 16,
                            ),
                            Text(
                              '${_weatherService.weather.forecastHourly[index]['precip_mm']} mm (${_weatherService.weather.forecastHourly[index]['chance_of_rain']}%)',
                              style: TextStyle(
                                fontSize: 10,
                                color: ThemeColors.secondaryColorDark,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.air,
                              color: ThemeColors.textColorDark,
                              size: 16,
                            ),
                            Text(
                              '${_weatherService.weather.forecastHourly[index]['wind_kph']} km/h (${_weatherService.weather.forecastHourly[index]['wind_dir']})',
                              style: TextStyle(
                                fontSize: 10,
                                color: ThemeColors.textColorDark,
                              ),
                            ),
                            Icon(
                              Icons.opacity,
                              color: ThemeColors.primaryColor,
                              size: 16,
                            ),
                            Text(
                              '${_weatherService.weather.forecastHourly[index]['humidity']} %',
                              style: TextStyle(
                                fontSize: 10,
                                color: ThemeColors.primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.cloud,
                              color: ThemeColors.blackColor,
                              size: 16,
                            ),
                            Text(
                              '${_weatherService.weather.forecastHourly[index]['cloud']} %',
                              style: TextStyle(
                                fontSize: 10,
                                color: ThemeColors.blackColor,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https:${_weatherService.weather.forecastHourly[index]['condition']['icon']}'))),
              );
            }));
  }
}
