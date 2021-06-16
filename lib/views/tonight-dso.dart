import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/oracowl.service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer.menu.dart';

class TonightDSO extends StatelessWidget {
  final OracowlService _oracowlService = OracowlService();
  TonightDSO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text('Profondo cielo'),
            elevation: 0,
            centerTitle: true,
            backgroundColor: ThemeColors.secondaryColor
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
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: ListView.builder(
                        itemCount: _oracowlService.tonightDSO.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.all(10),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,  //I assumed you want to occupy the entire space of the card
                                  image: CachedNetworkImageProvider(
                                    _oracowlService.tonightDSO[index]['image_url'],
                                  ),
                                ),
                              ),
                              child: Container(
                                color: Colors.black38,
                                child: ListTile(
                                  onTap: () {
                                    _openTelescopiusURL(_oracowlService.tonightDSO[index]['telescopius_url']);
                                  },
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${_oracowlService.tonightDSO[index]['familiar_name']} (${_oracowlService.tonightDSO[index]['alias'].replaceAll('-', ' ')})',
                                        style: TextStyle(
                                            color: ThemeColors.textColor,
                                          fontSize: 14
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                      Text(
                                        '${_oracowlService.tonightDSO[index]['constellation']}',
                                        style: TextStyle(
                                            color: ThemeColors.interactiveColor,
                                          fontSize: 10
                                        ),
                                      ),
                                      SizedBox(height: 25),
                                      Divider(height: 10, color: ThemeColors.textColor),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.lightbulb,
                                            color: ThemeColors.textColor,
                                            size: 12,
                                          ),
                                          Text(
                                            '${_oracowlService.tonightDSO[index]['magnitude']}',
                                            style: TextStyle(
                                                color: ThemeColors.textColor,
                                                fontSize: 10
                                            ),
                                          ),
                                          Icon(
                                            Icons.photo_size_select_actual_outlined,
                                            color: ThemeColors.textColor,
                                            size: 12,
                                          ),
                                          Text(
                                            '${_oracowlService.tonightDSO[index]['size']}',
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
                                            '${_oracowlService.tonightDSO[index]['altitude_at_sunset']}°',
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
                                            '${_oracowlService.tonightDSO[index]['altitude_at_sunrise']}°',
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
                                            '${_oracowlService.tonightDSO[index]['altitude_max']}°',
                                            style: TextStyle(
                                                color: ThemeColors.textColor,
                                                fontSize: 10
                                            ),
                                          ),
                                          Icon(
                                              Icons.compare_arrows,
                                              color: ThemeColors.textColor,
                                            size: 12,
                                          ),
                                          Text(
                                            '${_oracowlService.tonightDSO[index]['transit']}°',
                                            style: TextStyle(
                                                color: ThemeColors.textColor,
                                                fontSize: 10
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ]
            )
        )
    );
  }

  void _openTelescopiusURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
