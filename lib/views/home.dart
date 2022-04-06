import 'dart:async';

import 'package:astropills_tools/services/location.service.dart';
import 'package:astropills_tools/services/oracowl.service.dart';
import 'package:astropills_tools/views/drawer.menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  OracowlService _oracowlService = OracowlService();
  WeatherService _weatherService = WeatherService();
  LocationService _locationService = LocationService();
  String _timeString = '';
  late Timer _timer;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      String locale = context.locale.toStringWithSeparator();
      Intl.defaultLocale = locale;
      initializeDateFormatting(locale, null).then((value) {
        _getTime();
        _timer = Timer.periodic(Duration(seconds: 60), (Timer t) => _getTime());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Icon(
                Icons.refresh,
              ),
            ),
          )
        ],
      ),
      drawer: DrawerMenu(),
      body: Container(
        child: Stack(
          children: [
            Image.asset('assets/backgrounds/night.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
            Container(
              decoration: BoxDecoration(color: Colors.black26),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _openGoogleMapsURL();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 75),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: ThemeColors.interactiveColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    _locationService.locationAsString,
                                    style: TextStyle(
                                        fontSize: 10, color: ThemeColors.interactiveColor),
                                  ),
                                ],
                              ),
                              Text(
                                _weatherService.weather.location,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: ThemeColors.primaryColor),
                              ),
                              Text(
                                _timeString,
                                style: TextStyle(
                                    fontSize: 14, color: ThemeColors.textColor),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _openLunarCalendarURL();
                                  },
                                  child: Container(
                                    height: 128,
                                    width: 128,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(_weatherService
                                                .weather.astronomy['moon_icon']),
                                            fit: BoxFit.fill)),
                                    child: Center(
                                      child: Text(
                                          '${_weatherService.weather.astronomy['moon_illumination']}%',
                                          style: TextStyle(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeColors.textColor,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(3.0, 3.0),
                                                blurRadius: 3.0,
                                                color: Color.fromARGB(32, 0, 0, 0),
                                              ),
                                            ]
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _weatherService.weather.astronomy['moonrise'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ThemeColors.textColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.upgrade,
                                      color: ThemeColors.textColor,
                                      size: 18,
                                    ),
                                    Icon(
                                      Icons.vertical_align_bottom,
                                      color: ThemeColors.textColorDark,
                                      size: 18,
                                    ),
                                    Text(
                                      _weatherService.weather.astronomy['moonset'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ThemeColors.textColorDark,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    AlertDialog alert = AlertDialog(
                                      backgroundColor: ThemeColors.secondaryColorDark,
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Owl Rank',
                                            style: TextStyle(
                                                color: ThemeColors.primaryColorLight,
                                                fontSize: 32
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset('assets/icons/owlrank.png', width: 150),
                                            SizedBox(height: 20),
                                            Text(
                                              'oracowl_rank_info',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: ThemeColors.textColor
                                              ),
                                            ).tr(),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'close',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: ThemeColors.textColor
                                              ),
                                            ).tr()
                                        )
                                      ],
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 128,
                                    width: 128,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/icons/owlrank.png'),
                                            fit: BoxFit.fill)),
                                    child: Center(
                                      child: Text(
                                          _weatherService.weather.tonightRank,
                                          style: TextStyle(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeColors.textColor,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(3.0, 3.0),
                                                  blurRadius: 3.0,
                                                  color: Color.fromARGB(64, 0, 0, 0),
                                                ),
                                              ]
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Owl Rank',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ThemeColors.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_weatherService.weather.currentWeather['temp_c']}\u2103',
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.textColor),
                            ),
                            Row(children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, '/forecast');
                                  },
                                  child: CachedNetworkImage(
                                      imageUrl:
                                          'https:${_weatherService.weather.currentWeather['condition']['icon']}')),
                              Flexible(
                                child: Text(
                                  _weatherService.weather.currentWeather['condition']['text'],
                                  style: TextStyle(
                                      fontSize: 14, color: ThemeColors.textColor),
                                ),
                              )
                            ])
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white38)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.cloud,
                                size: 32,
                                color: ThemeColors.textColor,
                              ),
                              Text(
                                  '${_weatherService.weather.currentWeather['cloud']} %',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ThemeColors.textColor))
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.umbrella,
                                size: 32,
                                color: ThemeColors.textColor,
                              ),
                              Text(
                                  '${_weatherService.weather.currentWeather['chance_of_rain']} %',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ThemeColors.textColor)),
                              Text(
                                  '${_weatherService.weather.currentWeather['precip_mm']} mm',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: ThemeColors.textColor)),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.air,
                                size: 32,
                                color: ThemeColors.textColor,
                              ),
                              Text(
                                  '${_weatherService.weather.currentWeather['wind_kph']} km/h',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ThemeColors.textColor)),
                              Text(
                                  '${_weatherService.weather.currentWeather['wind_dir']}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: ThemeColors.textColor))
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.opacity,
                                size: 32,
                                color: ThemeColors.textColor,
                              ),
                              Text(
                                  '${_weatherService.weather.currentWeather['humidity']} %',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ThemeColors.textColor))
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE d MMMM yyyy HH:mm').format(dateTime);
  }

  void _openLunarCalendarURL() async {
    final lat = _locationService.position.latitude;
    final lon = _locationService.position.longitude;
    final url = 'https://www.timeanddate.com/moon/phases/@$lat,$lon';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void _openGoogleMapsURL() async {
    final lat = _locationService.position.latitude;
    final lon = _locationService.position.longitude;
    final url = 'https://www.google.com/maps/@$lat,$lon,13z';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
