import 'dart:convert';

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
    return _data['forecast']['forecastday'][0]['hour'][now.hour - 1];
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

  List<Map> get forecastTodayHourly {
    return _getForecastHourly(0);
  }

  List<Map> get forecastTomorrowHourly {
    return _getForecastHourly(1);
  }

  List<Map> get forecastAfterTomorrowHourly {
    return _getForecastHourly(2);
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
