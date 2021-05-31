import 'dart:convert';
import 'package:astropills_tools/core/config.dart';

class WeatherData {
  final Map _moonPhaseIcons = {
    'New Moon': 'assets/icons/moon/new.png',
    'Waxing Crescent': 'assets/icons/moon/waxing_crescent.png',
    'First Quarter': 'assets/icons/moon/first_quarter.png',
    'Waxing Gibbous': 'assets/icons/moon/waxing_gibbous.png',
    'Full Moon': 'assets/icons/moon/full.png',
    'Waning Gibbous': 'assets/icons/moon/waning_gibbous.png',
    'Last Quarter': 'assets/icons/moon/last_quarter.png',
    'Waning Crescent': 'assets/icons/moon/waning_crescent.png'
  };
  Map _data = Map();

  WeatherData.empty();
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

  bool get isDay {
    if (!loaded) {
      return true;
    }
    return _data['current']['is_day'] == 1;
  }

  Map get today {
    if (!loaded) {
      return {
        'max_temp_c': '0',
        'min_temp_c': '0',
        'daily_chance_of_rain': '0',
        'totalprecip_mm': '0',
        'maxwind_kph': '0'
      };
    }
    return _data['forecast']['forecastday'][0]['day'];
  }

  List<Map> get forecastHourly {
    if (!loaded) {
      return [];
    }
    List<Map> forecastHourlyList = [];
    for (int i = 0; i < _data['forecast']['forecastday'].length; i++) {
      for (int j = 0; j < _data['forecast']['forecastday'][i]['hour'].length; j++) {
        forecastHourlyList.add(_data['forecast']['forecastday'][i]['hour'][j]);
      }
    }
    return forecastHourlyList;
  }

  Map get astronomy {
    if (!loaded) {
      return {
        'sunrise': 'N/A',
        'sunset': 'N/A',
        'moonrise': 'N/A',
        'moonset': 'N/A',
        'moon_phase': 'N/A',
        'moon_illumination': 'N/A',
        'moon_icon': _moonPhaseIcons['New Moon']
      };
    }
    Map astronomy =  _data['forecast']['forecastday'][0]['astro'];
    astronomy['moon_icon'] = _moonPhaseIcons[astronomy['moon_phase']];
    return astronomy;
  }
}
