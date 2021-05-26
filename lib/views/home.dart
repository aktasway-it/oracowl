import 'package:astropills_tools/services/location.service.dart';
import 'package:flutter/material.dart';
import 'package:astropills_tools/services/moon.service.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MoonService _moonService = MoonService();
  WeatherService _weatherService = WeatherService();
  LocationService _locationService = LocationService();

  void loadData() async {
    Position? location = await _locationService.getCurrentLocation();
    if (location == null) {
      return;
    }
    bool isLoaded = await _weatherService.loadForecast(location.latitude, location.longitude);
    if (isLoaded) {
      setState(() {});
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AstroPills Tools'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        color: Colors.grey[850],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Image(
                          image: AssetImage(_moonService.getLunarPhaseImage()),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child:
                                Image.network(_weatherService.getCurrentIcon())))
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'ILLUMINAZIONE: ${_moonService.getLunarIllumination()}%',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(_weatherService.getCurrentDescription(),
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold))))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
