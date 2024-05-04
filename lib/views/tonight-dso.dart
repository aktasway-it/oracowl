import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/oracowl.service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer.menu.dart';

class TonightDSO extends StatelessWidget {
  final OracowlService _oracowlService = OracowlService();

  TonightDSO();

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
              title: Text(
                'deep_sky',
                style: TextStyle(color: ThemeColors.textColor),
              ).tr(),
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: ThemeColors.textColor),
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
                        height: 105,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            //I assumed you want to occupy the entire space of the card
                            image: CachedNetworkImageProvider(
                              _oracowlService.tonightDSO[index]['image_url'],
                            ),
                          ),
                        ),
                        child: Container(
                          color: Colors.black38,
                          child: ListTile(
                            onTap: () {
                              AlertDialog alert = AlertDialog(
                                backgroundColor: ThemeColors.secondaryColorDark,
                                title: Text(
                                  '${_oracowlService.tonightDSO[index]['familiar_name']}',
                                  style: TextStyle(
                                      color: ThemeColors.primaryColorLight),
                                ),
                                content: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CachedNetworkImage(
                                          imageUrl: _oracowlService
                                              .tonightDSO[index]['image_url']),
                                      SizedBox(height: 20),
                                      Text(
                                        'magnitude',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: ThemeColors.textColor),
                                      ).tr(args: [
                                        _oracowlService.tonightDSO[index]
                                                ['magnitude']
                                            .toString()
                                      ]),
                                      Text(
                                        'size',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: ThemeColors.textColor),
                                      ).tr(args: [
                                        _oracowlService.tonightDSO[index]
                                                ['size']
                                            .toString()
                                      ]),
                                      Text(
                                        'set_elevation',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: ThemeColors.textColor),
                                      ).tr(args: [
                                        _oracowlService.tonightDSO[index]
                                                ['altitude_at_sunset']
                                            .toString()
                                      ]),
                                      Text(
                                        'rise_elevation',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: ThemeColors.textColor),
                                      ).tr(args: [
                                        _oracowlService.tonightDSO[index]
                                                ['altitude_at_sunrise']
                                            .toString()
                                      ]),
                                      Text(
                                        'transit',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: ThemeColors.textColor),
                                      ).tr(args: [
                                        _oracowlService.tonightDSO[index]
                                                ['altitude_max']
                                            .toString(),
                                        _oracowlService.tonightDSO[index]
                                                ['transit']
                                            .toString()
                                      ]),
                                      Text(
                                        'transit_time',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: ThemeColors.textColor),
                                      ).tr(args: [
                                        _oracowlService.tonightDSO[index]
                                                ['transit']
                                            .toString()
                                      ])
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
                                            color: ThemeColors.textColor),
                                      ).tr()),
                                  TextButton(
                                      onPressed: () {
                                        _openTelescopiusURL(
                                            _oracowlService.tonightDSO[index]
                                                ['telescopius_url']);
                                      },
                                      child: Text(
                                        'open_telescopius',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                ThemeColors.interactiveColor),
                                      ).tr())
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    '${_oracowlService.tonightDSO[index]['familiar_name']} (${_oracowlService.tonightDSO[index]['alias'].replaceAll('-', ' ')})',
                                    style: TextStyle(
                                        color: ThemeColors.textColor,
                                        fontSize: 14),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Text(
                                  '${_oracowlService.tonightDSO[index]['constellation']}',
                                  style: TextStyle(
                                      color: ThemeColors.interactiveColor,
                                      fontSize: 10),
                                ),
                                SizedBox(height: 35),
                                Divider(
                                    height: 10, color: ThemeColors.textColor),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                          fontSize: 10),
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
                                          fontSize: 10),
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
                                          fontSize: 10),
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
                                          fontSize: 10),
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
                                          fontSize: 10),
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
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ]))),
    );
  }

  void _openTelescopiusURL(String url) async {
    final uri = Uri.parse(url);
    await canLaunchUrl(uri)
        ? await launchUrl(uri)
        : throw 'Could not launch $url';
  }
}
