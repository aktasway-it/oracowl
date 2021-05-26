import 'package:astropills_tools/models/weather.data.dart';
import 'package:http/http.dart';

class WeatherService {
  static final WeatherService _singleton = WeatherService._internal();
  factory WeatherService() => _singleton;
  WeatherService._internal();

  WeatherData _data = WeatherData.empty;

  Future<bool> loadForecast(double latitude, double longitude) async {
    if (!isDataLoaded()) {
      String requestURI = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appId=0bfbfead5d22a5123b78b6a46bcbde97&lang=it';
      Response response = await get(Uri.parse(requestURI));
      print(requestURI);
      print(response.body);
      this._data = WeatherData.parseJSONFeed(response.body);
    }
    return this.isDataLoaded();
  }

  bool isDataLoaded() {
    return this._data.loaded;
  }

  ForecastData getCurrentForecast() {
    if (!this.isDataLoaded()) {
      return ForecastData.empty;
    }
    return this._data.forecast[0];
  }
}
