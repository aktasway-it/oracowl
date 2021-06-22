import 'package:astropills_tools/core/theme.colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ForecastHour extends StatelessWidget {
  final Map _weatherData;

  const ForecastHour(this._weatherData);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(
            '${_weatherData['time'].split(' ')[1]}',
            style: TextStyle(
              fontSize: 14,
              color: ThemeColors.blackColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_weatherData['condition']['text']),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.umbrella,
                    color: ThemeColors.secondaryColorDark,
                    size: 16,
                  ),
                  Text(
                    '${_weatherData['precip_mm']} mm (${_weatherData['chance_of_rain']}%)',
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
                    '${_weatherData['wind_kph']} km/h (${_weatherData['wind_dir']})',
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
                    '${_weatherData['humidity']} %',
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
                    '${_weatherData['cloud']} %',
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.blackColor,
                    ),
                  )
                ],
              )
            ],
          ),
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(
                      'https:${_weatherData['condition']['icon']}')
              ),
              Text(
                '${_weatherData['temp_c']}° C',
                style: TextStyle(
                  fontSize: 10,
                  color: ThemeColors.blackColor,
                )
              )
            ],
          )),
    );
  }
}
