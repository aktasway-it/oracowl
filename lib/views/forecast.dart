import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:astropills_tools/views/forecast.hour.dart';
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
          backgroundColor: ThemeColors.primaryColor,
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                child: TabBar(
                  labelColor: ThemeColors.primaryColor,
                  tabs: [
                    Tab(text: 'Oggi'),
                    Tab(text: 'Domani'),
                    Tab(text: 'Dopodomani')
                  ]
                ),
              ),
              Expanded(
                child: TabBarView(
                    children: [
                      ListView.builder(
                          itemCount: _weatherService.weather.forecastTodayHourly.length,
                          itemBuilder: (context, index) {
                            return ForecastHour(_weatherService.weather.forecastTodayHourly[index]);
                            }
                      ),
                      ListView.builder(
                          itemCount: _weatherService.weather.forecastTodayHourly.length,
                          itemBuilder: (context, index) {
                            return ForecastHour(_weatherService.weather.forecastTomorrowHourly[index]);
                          }
                      ),
                      ListView.builder(
                          itemCount: _weatherService.weather.forecastTodayHourly.length,
                          itemBuilder: (context, index) {
                            return ForecastHour(_weatherService.weather.forecastAfterTomorrowHourly[index]);
                          }
                      )
                    ]
                ),
              )
            ],
          )
        )
    );
  }
}
