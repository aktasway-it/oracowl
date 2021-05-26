import 'dart:convert';
import 'package:astropills_tools/core/config.dart';

class WindData {
  final int speed;
  final int gust;
  final int degrees;

  WindData(this.speed, this.gust, this.degrees);

  static get empty {
    return WindData(0, 0, 0);
  }
}

class ForecastData {
  final String tag;
  final String description;
  final String icon;
  final int clouds;
  final WindData wind;
  final int temperature;
  final int humidity;
  final DateTime date;

  ForecastData(
    this.tag,
    this.description,
    this.icon,
    this.clouds,
    this.wind,
    this.temperature,
    this.humidity,
    this.date,
  );

  static get empty {
    return ForecastData(
      'N/A',
      'N/A',
      Config.weatherIconBaseURL + '01n' + Config.weatherIconSuffix,
      0,
      WindData.empty,
      0,
      0,
      DateTime.now(),
    );
  }

  static ForecastData fromMap(Map data) {
    String tag = data['weather'][0]['main'];
    String description = data['weather'][0]['description'];
    String icon = Config.weatherIconBaseURL +
        data['weather'][0]['icon'] +
        Config.weatherIconSuffix;
    int clouds = data['clouds']['all'];
    int temperature = (data['main']['temp'] - 273.15).round();
    int humidity = data['main']['humidity'];
    int windSpeed = (data['wind']['speed']).round();
    int windDirection = data['wind']['deg'];
    int windGust = (data['wind']['gust']).round();
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);

    int windSpeedToKMH = (windSpeed * 3.6).round();
    int windGustToKMH = (windGust * 3.6).round();

    return ForecastData(
        tag,
        description,
        icon,
        clouds,
        WindData(windSpeedToKMH, windGustToKMH, windDirection),
        temperature,
        humidity,
        date);
  }
}

class LocationData {
  final String city;

  final DateTime sunrise;
  final DateTime sunset;

  LocationData(this.city, this.sunrise, this.sunset);

  static get empty {
    return LocationData('N/A', DateTime.now(), DateTime.now());
  }

  static LocationData fromMap(Map data) {
    String city = data['name'];
    DateTime sunrise =
        DateTime.fromMillisecondsSinceEpoch(data['sunrise'] * 1000);
    DateTime sunset =
        DateTime.fromMillisecondsSinceEpoch(data['sunset'] * 1000);

    return LocationData(city, sunrise, sunset);
  }
}

class WeatherData {
  final LocationData location;
  final List<ForecastData> forecast;

  WeatherData(this.location, this.forecast);

  bool get loaded {
    return forecast.isNotEmpty;
  }

  static WeatherData parseJSONFeed(String json) {
    try {
      Map data = jsonDecode(json);
      LocationData location = LocationData.fromMap(data['city']);
      List<ForecastData> forecast = [];
      for (int i = 0; i < data['list'].length; i++) {
        forecast.add(ForecastData.fromMap(data['list'][i]));
      }
      return WeatherData(location, forecast);
    } catch (ex) {
      return empty;
    }
  }

  static WeatherData get empty {
    return WeatherData(LocationData.empty, []);
  }
}
