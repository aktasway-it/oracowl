import 'package:astropills_tools/models/weather.data.dart';
import 'package:http/http.dart';

class WeatherService {
  static final WeatherService _singleton = WeatherService._internal();
  factory WeatherService() => _singleton;
  WeatherService._internal();

  WeatherData _data = WeatherData.empty();

  Future<void> loadForecast(double latitude, double longitude, {forceReload = false}) async {
    if (!isDataLoaded() || forceReload) {
      String requestURI = 'http://api.weatherapi.com/v1/forecast.json?key=0f8b0d0a304f460fbbb72025212705&q=$latitude,$longitude&days=3&lang=it';
      Response response = await get(Uri.parse(requestURI));
      print(requestURI);
      print(response.body);
      this._data = WeatherData(response.body);
    }
  }

  bool isDataLoaded() {
    return this._data.loaded;
  }

  WeatherData get weather {
    return this._data;
  }
}
