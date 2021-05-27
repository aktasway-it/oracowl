import 'dart:convert';
import 'package:astropills_tools/core/config.dart';

class WeatherData {
  Map _data = Map();

  WeatherData(String jsonData) {
    try {
      this._data = jsonDecode(jsonData);
    } catch (ex) {
      this._data = Map();
      print('Could not load weather data: $ex');
    }
  }

  bool get loaded {
    return _data.isNotEmpty;
  }

  String get location {
    if (!loaded) {
      return 'Loading...';
    }
    return _data['location']['name'];
  }

  String get currentWeatherText {
    if (!loaded) {
      return 'Loading...';
    }
    return _data['current']['condition']['text'];
  }

  String get currentWeatherIcon {
    if (!loaded) {
      return 'https://cdn.weatherapi.com/weather/128x128/day/116.png';
    }
    return 'https:' + _data['current']['condition']['icon'].replaceAll('64x64', '128x128');
  }
}
