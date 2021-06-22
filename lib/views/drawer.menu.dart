import 'package:astropills_tools/core/theme.colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu();

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
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text('Scegli località'),
            leading: Icon(Icons.location_on),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/location');
            },
          ),
          ListTile(
            title: Text('Meteo'),
            leading: Icon(Icons.wb_sunny),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/forecast');
            },
          ),
          ListTile(
            title: Text('Orologio Polare'),
            leading: Icon(Icons.timelapse),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/polar');
            },
          ),
          ListTile(
            title: Text('Profondo Cielo'),
            leading: Icon(Icons.auto_awesome),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tonight/dso');
            },
          ),
          ListTile(
            title: Text('Pianeti'),
            leading: Icon(Icons.hdr_strong),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tonight/planets');
            },
          ),
          ListTile(
            title: Text('Tutorials'),
            leading: Icon(Icons.ondemand_video),
            onTap: () {
              _openYoutubeURL();
            },
          ),
          ListTile(
            title: Text('Invia un feedback'),
            leading: Icon(Icons.email),
            onTap: () {
              _openFeedbackURL();
            },
          )
        ],
      ),
    );
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
