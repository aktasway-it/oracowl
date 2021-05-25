import 'package:http/http.dart';
import 'dart:convert';

class WeatherService {
  static Map _forecast = Map();
  static loadForecast() async {
    if (_forecast.isEmpty) {
      Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?lat=42.2265&lon=14.3890&appId=0bfbfead5d22a5123b78b6a46bcbde97&lang=it"));
      print(response.body);
      _forecast = jsonDecode(response.body);
    }
    return isForecastLoaded();
  }

  static bool isForecastLoaded() {
    return _forecast.isNotEmpty && _forecast['cod'] == '200';
  }

  static String getCurrentIcon() {
    if (!isForecastLoaded()) {
      return 'https://openweathermap.org/img/wn/01n@2x.png';
    }
    return 'https://openweathermap.org/img/wn/${_forecast['list'][0]['weather'][0]['icon']}@2x.png';
  }

  static String getCurrentDescription() {
    if (!isForecastLoaded()) {
      return 'LOADING';
    }
    return _forecast['list'][0]['weather'][0]['description'].toUpperCase();
  }
}
