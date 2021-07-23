import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:astropills_tools/views/drawer.menu.dart';
import 'package:astropills_tools/views/forecast.hour.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Forecast extends StatefulWidget {
  const Forecast();

  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  WeatherService _weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('${_weatherService.weather.location}'),
            centerTitle: true,
            backgroundColor: ThemeColors.secondaryColor,
          ),
          drawer: DrawerMenu(),
          body: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  child: TabBar(
                    labelColor: ThemeColors.secondaryColor,
                    tabs: [
                      Tab(text: _getTodayString()),
                      Tab(text: _getTomorrowString()),
                      Tab(text: _getAfterTomorrowString())
                    ]
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      children: [
                        ListView.builder(
                            itemCount: _weatherService.weather.forecastTodayHourly.length,
                            itemBuilder: (context, index) {
                              return ForecastHour(0, index, _weatherService.weather.forecastTodayHourly[index]);
                              }
                        ),
                        ListView.builder(
                            itemCount: _weatherService.weather.forecastTomorrowHourly.length,
                            itemBuilder: (context, index) {
                              return ForecastHour(1, index, _weatherService.weather.forecastTomorrowHourly[index]);
                            }
                        ),
                        ListView.builder(
                            itemCount: _weatherService.weather.forecastAfterTomorrowHourly.length,
                            itemBuilder: (context, index) {
                              return ForecastHour(2, index, _weatherService.weather.forecastAfterTomorrowHourly[index]);
                            }
                        )
                      ]
                  ),
                )
              ],
            )
          )
      ),
    );
  }

  String _getTodayString() {
    return DateFormat('EEEE d').format(DateTime.now());
  }

  String _getTomorrowString() {
    return DateFormat('EEEE d').format(DateTime.now().add(Duration(days: 1)));
  }

  String _getAfterTomorrowString() {
    return DateFormat('EEEE d').format(DateTime.now().add(Duration(days: 2)));
  }
}
