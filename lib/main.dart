import 'package:flutter/material.dart';
import 'package:astropills_tools/views/home.dart';
import 'package:astropills_tools/views/loading.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'LemonMilk'),
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
    },
  ));
}

