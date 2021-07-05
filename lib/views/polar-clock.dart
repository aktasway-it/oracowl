import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/oracowl.service.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'drawer.menu.dart';

class PolarClock extends StatefulWidget {
  const PolarClock();

  @override
  _PolarClockState createState() => _PolarClockState();
}

class _PolarClockState extends State<PolarClock> {
  OracowlService _oracowlService = OracowlService();

  double _dotX = 0;
  double _dotY = 0;

  @override
  void initState() {
    List dotPosition = _getDotPosition();
    _dotX = dotPosition[0];
    _dotY = dotPosition[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''),
          elevation: 0,
          backgroundColor: Colors.transparent
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
                    padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              Image.asset('assets/images/polar_clock.png'),
                              Positioned(
                                  left: _dotX,
                                  top: _dotY,
                                  child: Image.asset('assets/images/dot.png', color: ThemeColors.interactiveColor)
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment:  MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Polaris HA',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.primaryColor
                                    ),
                                  ),
                                  Text(
                                    _oracowlService.polaris['hour_angle_ra'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.textColor
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Ora siderale',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.primaryColor
                                    ),
                                  ),
                                  Text(
                                    _oracowlService.polaris['sidereal_time'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.textColor
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              ]
            )
        )
    );
  }

  List _getDotPosition() {
    double x = 128 + 128 * cos((pi / 2) - _oracowlService.polaris['hour_angle_radians']);
    double y = 128 + 128 * sin((pi / 2) - _oracowlService.polaris['hour_angle_radians']);

    x = x < 128 ? x : x - 16;
    y = y < 128 ? y : y - 16;
    return [x, y];
  }
}
