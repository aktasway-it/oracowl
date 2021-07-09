import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ForecastHour extends StatefulWidget {
  final int _day;
  final int _hour;
  final Map _weatherData;

  const ForecastHour(this._day, this._hour, this._weatherData);

  @override
  State<ForecastHour> createState() => _ForecastHourState();
}

class _ForecastHourState extends State<ForecastHour> {
  final WeatherService _weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(
            '${widget._weatherData['time'].split(' ')[1]}',
            style: TextStyle(
              fontSize: 14,
              color: ThemeColors.blackColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget._weatherData['condition']['text']),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.cloud,
                    color: ThemeColors.blackColor,
                    size: 16,
                  ),
                  Text(
                    '${widget._weatherData['cloud']} %',
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.blackColor,
                    ),
                  ),
                  Icon(
                    Icons.umbrella,
                    color: ThemeColors.secondaryColorDark,
                    size: 16,
                  ),
                  Text(
                    '${widget._weatherData['precip_mm']} mm (${widget._weatherData['chance_of_rain']}%)',
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
                    '${widget._weatherData['wind_kph']} km/h (${widget._weatherData['wind_dir']})',
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
                    '${widget._weatherData['humidity']} %',
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.primaryColor,
                    ),
                  )
                ],
              )
            ],
          ),
          leading: Container(
            width: 85,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/owlrank.png'),
                          fit: BoxFit.fill)),
                  child: Center(
                    child: Text(
                        _weatherService.weather.getHourRank(widget._day, int.parse(widget._weatherData['time'].split(' ')[1].split(':')[0])),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.textColor,
                            shadows: [
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(64, 0, 0, 0),
                              ),
                            ]
                        )),
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.transparent,
                        backgroundImage: CachedNetworkImageProvider(
                            'https:${widget._weatherData['condition']['icon']}')
                    ),
                    Text(
                        '${widget._weatherData['temp_c']}° C',
                        style: TextStyle(
                          fontSize: 10,
                          color: ThemeColors.blackColor,
                        )
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
