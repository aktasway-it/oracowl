import 'package:flutter/material.dart';
import 'package:astropills_tools/services/moon.service.dart';
import 'package:astropills_tools/services/weather.service.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void loadWeatherData() async {
    bool isLoaded = await WeatherService.loadForecast();
    if (isLoaded) {
      setState(() {});
    }
  }

  @override
  void initState() {
    loadWeatherData();
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
                          image: AssetImage(MoonService.getLunarPhaseImage()),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child:
                                Image.network(WeatherService.getCurrentIcon())))
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
                          'ILLUMINAZIONE: ${MoonService.getLunarIllumination()}%',
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
                            child: Text(WeatherService.getCurrentDescription(),
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
