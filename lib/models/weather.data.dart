import 'dart:convert';

import 'dart:math';

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

  Map get currentWeather {
    if (!loaded) {
      return Map();
    }
    DateTime now = DateTime.now();
    return _data['forecast']['forecastday'][0]['hour'][now.hour];
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

  List<Map> _getForecastHourly(int dayIndex) {
    if (!loaded) {
      return [];
    }
    List<Map> forecastHourlyList = [];
    for (int j = 0; j < _data['forecast']['forecastday'][dayIndex]['hour'].length; j++) {
      forecastHourlyList.add(_data['forecast']['forecastday'][dayIndex]['hour'][j]);
    }
    return forecastHourlyList;
  }
  
  String _calculateRank(int moon, int clouds, int rain, int wind, int humidity) {
    if (rain >= 20) {
      return 'E';
    }
    
    int moonScore = ((100 - moon) * 0.3).round();
    int cloudsScore = (max((50 - clouds), 0) / 50 * 100 * 0.4).round();
    int windScore = (max((20 - wind), 0) / 20 * 100 * 0.2).round();
    int humidityScore = ((100 - humidity) * 0.1).round();

    /*print('$moon, $clouds, $wind, $humidity');
    print('M: $moonScore, C: $cloudsScore, W: $windScore, H: $humidityScore');*/

    int totalScore = moonScore + cloudsScore + windScore + humidityScore;
    if (totalScore > 90) {
      return 'A';
    } else if (totalScore > 70) {
      return 'B';
    } else if (totalScore > 50) {
      return 'C';
    } else if (totalScore > 30) {
      return 'D';
    } else if (totalScore > 70) {
      return 'E';
    }

    return 'N/A';
  }

  String getHourRank(int day, int hour) {
    int moonIllumination = int.parse(astronomy['moon_illumination']);
    int clouds = _getForecastHourly(day)[hour]['cloud'];
    int wind = _getForecastHourly(day)[hour]['wind_kph'].round();
    int humidity = _getForecastHourly(day)[hour]['humidity'];
    int rain = int.parse(_getForecastHourly(day)[hour]['chance_of_rain']);
    
    return _calculateRank(moonIllumination, clouds, rain, wind, humidity);
  }

  List<Map> get forecastTodayHourly {
    DateTime now = DateTime.now();
    int hourIndex = now.hour;
    return _getForecastHourly(0).sublist(hourIndex);
  }

  List<Map> get forecastTomorrowHourly {
    return _getForecastHourly(1);
  }

  List<Map> get forecastAfterTomorrowHourly {
    return _getForecastHourly(2);
  }

  String get tonightRank {
    double avgClouds = 0;
    double avgRain = 0;
    double avgWind = 0;
    double avgHumidity = 0;

    int moonIllumination = int.parse(astronomy['moon_illumination']);
    if (moonIllumination >= 90) {
      return 'E';
    }
    List todayForecast = _getForecastHourly(0);
    for (int i = 20; i < todayForecast.length; i++) {
      if (int.parse(todayForecast[i]['chance_of_rain']) > 30) {
        return 'E';
      }
      avgClouds += todayForecast[i]['cloud'];
      avgRain += int.parse(todayForecast[i]['chance_of_rain']);
      avgWind += todayForecast[i]['wind_kph'];
      avgHumidity += todayForecast[i]['humidity'];
    }
    for (int i = 0; i < 5; i++) {
      if (int.parse(forecastTomorrowHourly[i]['chance_of_rain']) > 30) {
        return 'E';
      }
      avgClouds += forecastTomorrowHourly[i]['cloud'];
      avgWind += forecastTomorrowHourly[i]['wind_kph'];
      avgHumidity += forecastTomorrowHourly[i]['humidity'];
    }

    avgClouds /= 10;
    avgRain /= 10;
    avgWind /= 10;
    avgHumidity /= 10;

    return _calculateRank(moonIllumination, avgClouds.round(), avgRain.round(), avgWind.round(), avgHumidity.round());
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
