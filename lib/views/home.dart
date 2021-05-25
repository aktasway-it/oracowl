import 'package:flutter/material.dart';
import 'package:astropills_tools/services/moon.service.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
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
                  Expanded(flex: 1, child: Center(child: Text('Weather Icon')))
                ]
              ),
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
                        'Illuminazione: ${MoonService.getLunarIllumination()}%',
                        style: TextStyle(
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(flex: 1, child: Center(child: Text('Weather Text')))
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
