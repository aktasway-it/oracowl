import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/location.service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu();

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Container(
                child: Column(
                  children: [
                    Image.asset('assets/icons/oracowl.png'),
                    Text(
                      'ORACOWL',
                      style: TextStyle(fontSize: 24, color: ThemeColors.textColor),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      ThemeColors.primaryColor, ThemeColors.secondaryColor
                    ]
                ),
              )
          ),
          ListTile(
            title: Text('home').tr(),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text('pick_location').tr(),
            leading: Icon(Icons.location_on),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/location');
            },
          ),
          ListTile(
            title: Text('weather').tr(),
            leading: Icon(Icons.wb_sunny),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/forecast');
            },
          ),
          ListTile(
            title: Text('deep_sky').tr(),
            leading: Icon(Icons.auto_awesome),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tonight/dso');
            },
          ),
          ListTile(
            title: Text('planets').tr(),
            leading: Icon(Icons.hdr_strong),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tonight/planets');
            },
          ),
          ExpansionTile(
            title: Text("tools").tr(),
            leading: Icon(Icons.construction),
            children: [
              ListTile(
                title: Text('polar_clock').tr(),
                leading: Icon(Icons.timelapse),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/polar');
                },
              ),
              ListTile(
                title: Text('moon_calendar').tr(),
                leading: Icon(Icons.lens),
                onTap: () {
                  _openLunarCalendarURL();
                },
              ),
              ListTile(
                title: Text('calculators').tr(),
                leading: Icon(Icons.calculate),
                onTap: () {
                  _openCalculatorsURL();
                },
              ),
              ListTile(
                title: Text('dark_sky_maps').tr(),
                leading: Icon(Icons.dark_mode),
                onTap: () {
                  _openDarkSkyMapURL();
                },
              ),
              ListTile(
                title: Text('stellarium').tr(),
                leading: Icon(Icons.star),
                onTap: () {
                  _openStellariumURL();
                },
              ),
            ],
          ),
          ListTile(
            title: Text('tutorials').tr(),
            leading: Icon(Icons.ondemand_video),
            onTap: () {
              _openYoutubeURL();
            },
          ),
          ListTile(
            title: Text('send_feedback').tr(),
            leading: Icon(Icons.email),
            onTap: () {
              _openFeedbackURL();
            },
          )
        ],
      ),
    );
  }

  void _openStellariumURL() async {
    final url = 'https://stellarium-web.org/';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void _openCalculatorsURL() async {
    final url = 'https://astronomy.tools/calculators/ccd';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void _openLunarCalendarURL() async {
    final lat = _locationService.position.latitude;
    final lon = _locationService.position.longitude;
    final url = 'https://www.timeanddate.com/moon/phases/@$lat,$lon';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void _openDarkSkyMapURL() async {
    final lat = _locationService.position.latitude;
    final lon = _locationService.position.longitude;
    final url = 'https://www.lightpollutionmap.info/#zoom=10.00&lat=$lat&lon=$lon&layers=B0FFFFFFTFFFFFTFFFF';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void _openYoutubeURL() async {
    final url = 'https://www.youtube.com/c/AstroPills';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void _openFeedbackURL() async {
    final url = 'mailto:astropills.it@gmail.com?subject=Feedback Oracowl';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
