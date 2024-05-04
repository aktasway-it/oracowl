import 'package:astropills_tools/models/weather.data.dart';
import 'package:http/http.dart';

class WeatherService {
  static final WeatherService _singleton = WeatherService._internal();
  factory WeatherService() => _singleton;
  WeatherService._internal();

  WeatherData _data = WeatherData.empty();

  Future<bool> loadForecast(double latitude, double longitude, String locale,
      {forceReload = false}) async {
    try {
      if (!isDataLoaded() || forceReload) {
        String requestURI =
            'https://api2.oracowl.io/weather?lat=$latitude&lon=$longitude&lang=$locale';
        Response response = await get(Uri.parse(requestURI));
        this._data = WeatherData(response.body);
      }
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    return isDataLoaded();
  }

  bool isDataLoaded() {
    return this._data.loaded;
  }

  WeatherData get weather {
    return this._data;
  }
}
