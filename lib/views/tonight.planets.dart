import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/oracowl.service.dart';
import 'package:flutter/material.dart';

import 'drawer.menu.dart';

class TonightPlanets extends StatelessWidget {
  final OracowlService _oracowlService = OracowlService();
  TonightPlanets();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return true;
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              title: Text('Pianeti'),
              elevation: 0,
              centerTitle: true,
              backgroundColor: ThemeColors.secondaryColor),
          drawer: DrawerMenu(),
          body: Container(
              child: Stack(children: [
            Image.asset('assets/backgrounds/night.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
            Container(
              decoration: BoxDecoration(color: Colors.black26),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ListView.builder(
                    itemCount: _oracowlService.tonightPlanets.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset('assets/icons/planets/${_oracowlService.tonightPlanets[index]['name']}.png'),
                        onTap: () {
                          AlertDialog alert = AlertDialog(
                            backgroundColor: ThemeColors.secondaryColorDark,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _oracowlService.tonightPlanets[index]['name'],
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
                                  Image.asset('assets/icons/planets/${_oracowlService.tonightPlanets[index]['name']}.png'),
                                  SizedBox(height: 20),
                                  Text(
                                    'Distanza dalla terra: ${_oracowlService.tonightPlanets[index]['earth_distance']} UA',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ThemeColors.textColor
                                    ),
                                  ),
                                  Text(
                                    'Sorge: ${_oracowlService.tonightPlanets[index]['rise_time']}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ThemeColors.textColor
                                    ),
                                  ),
                                  Text(
                                    'Tramonta: ${_oracowlService.tonightPlanets[index]['set_time']}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ThemeColors.textColor
                                    ),
                                  ),
                                  Text(
                                    'Massima altezza: ${_oracowlService.tonightPlanets[index]['max_altitude']}° (${_oracowlService.tonightPlanets[index]['max_altitude_time']})',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ThemeColors.textColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Chiudi',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ThemeColors.textColor
                                    ),
                                  )
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
                        title: Text(
                            _oracowlService.tonightPlanets[index]['name'],
                          style: TextStyle(
                            fontSize: 20,
                            color: ThemeColors.interactiveColor,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.social_distance,
                              color: ThemeColors.textColor,
                              size: 12,
                            ),
                            Text(
                              '${_oracowlService.tonightPlanets[index]['earth_distance']} AU',
                              style: TextStyle(
                                  color: ThemeColors.textColor,
                                  fontSize: 10
                              ),
                            ),
                            Icon(
                              Icons.upgrade,
                              color: ThemeColors.textColor,
                              size: 12,
                            ),
                            Text(
                              '${_oracowlService.tonightPlanets[index]['rise_time']}',
                              style: TextStyle(
                                  color: ThemeColors.textColor,
                                  fontSize: 10
                              ),
                            ),
                            Icon(
                              Icons.vertical_align_bottom,
                              color: ThemeColors.textColor,
                              size: 12,
                            ),
                            Text(
                              '${_oracowlService.tonightPlanets[index]['set_time']}°',
                              style: TextStyle(
                                  color: ThemeColors.textColor,
                                  fontSize: 10
                              ),
                            ),
                            Icon(
                              Icons.height,
                              color: ThemeColors.textColor,
                              size: 12,
                            ),
                            Text(
                              '${_oracowlService.tonightPlanets[index]['max_altitude']}° (${_oracowlService.tonightPlanets[index]['max_altitude_time']})',
                              style: TextStyle(
                                  color: ThemeColors.textColor,
                                  fontSize: 10
                              ),
                            ),
                          ],
                        ),
                      );
                    }))
          ]))),
    );
  }
}
