import 'package:astropills_tools/views/forecast.dart';
import 'package:astropills_tools/views/location-picker.dart';
import 'package:astropills_tools/views/polar-clock.dart';
import 'package:astropills_tools/views/tonight-dso.dart';
import 'package:astropills_tools/views/tonight.planets.dart';
import 'package:flutter/material.dart';
import 'package:astropills_tools/views/home.dart';
import 'package:astropills_tools/views/loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'LemonMilk'),
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/forecast': (context) => Forecast(),
      '/polar': (context) => PolarClock(),
      '/tonight/dso': (context) => TonightDSO(),
      '/tonight/planets': (context) => TonightPlanets(),
      '/location': (context) => LocationPicker(),
    },
  ));
}

