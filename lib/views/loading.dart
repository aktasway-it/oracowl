import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/location.service.dart';
import 'package:astropills_tools/services/oracowl.service.dart';
import 'package:astropills_tools/services/weather.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Loading extends StatefulWidget {
  const Loading();

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  OracowlService _oracowlService = OracowlService();
  WeatherService _weatherService = WeatherService();
  LocationService _locationService = LocationService();
  bool _showReload = false;

  void loadData() async {
    setState(() {
      _showReload = false;
    });
    bool positionLoaded =
        await _locationService.fetchCurrentLocation();
    if (!positionLoaded) {
      showLocationToast();
      Navigator.pushReplacementNamed(context, '/location');
      return;
    }
    bool oracowlLoaded = await _oracowlService.loadData(_locationService.position.latitude, _locationService.position.longitude,
        forceReload: true);
    if (!oracowlLoaded) {
      oracowlLoaded = await _oracowlService.loadData(_locationService.position.latitude, _locationService.position.longitude,
          forceReload: true, backupService: true);
    }
    bool weatherLoaded = await _weatherService.loadForecast(_locationService.position.latitude, _locationService.position.longitude,
        forceReload: true);
    if (oracowlLoaded && weatherLoaded) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showErrorToast();
    }
  }

  showLocationToast() {
    Fluttertoast.showToast(
        msg: "Oracowl ha bisogno di poter accedere alla tua posizione per caricare automaticamente i dati.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ThemeColors.secondaryColor,
        textColor: ThemeColors.textColor,
        fontSize: 16.0
    );
    setState(() {
      _showReload = true;
    });
  }

  showErrorToast() {
    Fluttertoast.showToast(
        msg: "Impossibile stabilire una connessione, riprova.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ThemeColors.secondaryColor,
        textColor: ThemeColors.textColor,
        fontSize: 16.0
    );
    setState(() {
      _showReload = true;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.primaryColorDark,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/oracowl.png'),
                Text(
                  'ORACOWL',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.textColor
                  )
                ),
                !_showReload ? SpinKitRipple(
                  color: ThemeColors.textColor,
                  size: 50.0,
                ) : TextButton(
                    onPressed: () {
                      loadData();
                    },
                    child: Text(
                        'Ricarica',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.interactiveColor
                        )
                    )
                )
              ],
            ),
          ),
        ));
  }
}
