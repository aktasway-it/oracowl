import 'dart:convert';

import 'dart:math';

import 'package:astropills_tools/services/oracowl.service.dart';

class WeatherData {
  final Map _moonPhaseIcons = {
    'new': 'assets/icons/moon/new.png',
    'waxing_crescent': 'assets/icons/moon/waxing_crescent.png',
    'first_quarter': 'assets/icons/moon/first_quarter.png',
    'waxing_gibbous': 'assets/icons/moon/waxing_gibbous.png',
    'full': 'assets/icons/moon/full.png',
    'waning_gibbous': 'assets/icons/moon/waning_gibbous.png',
    'last_quarter': 'assets/icons/moon/last_quarter.png',
    'waning_crescent': 'assets/icons/moon/waning_crescent.png'
  };
  final List _phases = [
    ['new', 0, 10],
    ['waxing_crescent', 10, 40],
    ['first_quarter', 40, 70],
    ['waxing_gibbous', 70, 95],
    ['full', 95, 105],
    ['waning_gibbous', 105, 130],
    ['last_quarter', 130, 160],
    ['waning_crescent', 160, 190],
    ['new', 190, 200],
  ];
  Map _data = Map();
  OracowlService _oracowlService = OracowlService();

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

  String _getLunarPhaseImage() {
    int phase = _oracowlService.tonightPlanets[1]['phase_string'] == 'waxing' ?
    _oracowlService.tonightPlanets[1]['phase'] : 100 + (100 - _oracowlService.tonightPlanets[1]['phase']);
    for (int i = 0; i < this._phases.length; i++) {
      if (phase >= this._phases[i][1] && phase <= this._phases[i][2]) {
        return 'assets/icons/moon/${this._phases[i][0]}.png';
      }
    }
    return 'assets/icons/moon/full.png';
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
    } else {
      return 'E';
    }
  }

  String getHourRank(int day, int hour) {
    try {
      int moonIllumination = int.parse(astronomy['moon_illumination']);
      int clouds = _getForecastHourly(day)[hour]['cloud'];
      int wind = _getForecastHourly(day)[hour]['wind_kph'].round();
      int humidity = _getForecastHourly(day)[hour]['humidity'];
      int rain = _getForecastHourly(day)[hour]['chance_of_rain'];
      return _calculateRank(moonIllumination, clouds, rain, wind, humidity);
    } catch(ex) {
      return 'N/A';
    }
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
    try {
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
        if (todayForecast[i]['chance_of_rain'] > 30) {
          return 'E';
        }
        avgClouds += todayForecast[i]['cloud'];
        avgRain += todayForecast[i]['chance_of_rain'];
        avgWind += todayForecast[i]['wind_kph'];
        avgHumidity += todayForecast[i]['humidity'];
      }
      for (int i = 0; i < 5; i++) {
        if (forecastTomorrowHourly[i]['chance_of_rain'] > 30) {
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

      return _calculateRank(
          moonIllumination, avgClouds.round(), avgRain.round(), avgWind.round(),
          avgHumidity.round());
    } catch(ex) {
      return 'N/A';
    }
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
    astronomy['moon_illumination'] = _oracowlService.tonightPlanets[1]['phase'].toString();
    astronomy['moon_icon'] = _getLunarPhaseImage();
    astronomy['moonrise'] = _oracowlService.tonightPlanets[1]['rise_time'];
    astronomy['moonset'] = _oracowlService.tonightPlanets[1]['set_time'];
    return astronomy;
  }
}
