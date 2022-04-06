import 'package:astropills_tools/views/forecast.dart';
import 'package:astropills_tools/views/location-picker.dart';
import 'package:astropills_tools/views/polar-clock.dart';
import 'package:astropills_tools/views/tonight-dso.dart';
import 'package:astropills_tools/views/tonight.planets.dart';
import 'package:flutter/material.dart';
import 'package:astropills_tools/views/home.dart';
import 'package:astropills_tools/views/loading.dart';
import 'package:easy_localization/easy_localization.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('it')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: OracowlApp()
    ),
  );
}

class OracowlApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
    );
  }
}

