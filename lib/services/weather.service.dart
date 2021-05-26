import 'package:http/http.dart';
import 'dart:convert';

class WeatherService {
  static final WeatherService _singleton = WeatherService._internal();

  factory WeatherService() => _singleton;

  WeatherService._internal();

  Map _forecast = Map();

  Future<bool> loadForecast(double latitude, double longitude) async {
    if (_forecast.isEmpty) {
      String requestURI = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appId=0bfbfead5d22a5123b78b6a46bcbde97&lang=it';
      Response response = await get(Uri.parse(requestURI));
      print(requestURI);
      print(response.body);
      this._forecast = jsonDecode(response.body);
    }
    return this.isForecastLoaded();
  }

  bool isForecastLoaded() {
    return this._forecast.isNotEmpty && this._forecast['cod'] == '200';
  }

  String getCurrentIcon() {
    if (!this.isForecastLoaded()) {
      return 'https://openweathermap.org/img/wn/01n@2x.png';
    }
    return 'https://openweathermap.org/img/wn/${this._forecast['list'][0]['weather'][0]['icon']}@2x.png';
  }

  String getCurrentDescription() {
    if (!this.isForecastLoaded()) {
      return 'LOADING';
    }
    return this._forecast['list'][0]['weather'][0]['description'].toUpperCase();
  }
}
