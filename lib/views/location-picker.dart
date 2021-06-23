import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/location.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'drawer.menu.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker();

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final _formKey = GlobalKey<FormBuilderState>();
  LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text('Scegli località'),
            elevation: 0,
            centerTitle: true,
            backgroundColor: ThemeColors.secondaryColor),
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
            padding: EdgeInsets.fromLTRB(10, 90, 10, 0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'latitude',
                    style: TextStyle(color: ThemeColors.textColor),
                    decoration: InputDecoration(
                        labelText: 'Latitudine',
                        labelStyle: TextStyle(color: ThemeColors.primaryColor)),
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderTextField(
                    name: 'longitude',
                    style: TextStyle(color: ThemeColors.textColor),
                    decoration: InputDecoration(
                        labelText: 'Longitudine',
                        labelStyle: TextStyle(color: ThemeColors.primaryColor)),
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            try {
                              final latitude = double.parse(_formKey
                                  .currentState!.fields['latitude']!.value);
                              final longitude = double.parse(_formKey
                                  .currentState!.fields['longitude']!.value);
                              _locationService.createPositionFromLatLon(
                                  latitude, longitude);
                              Navigator.pushReplacementNamed(context, '/');
                            } catch(ex) {
                              Fluttertoast.showToast(
                                  msg: "Inserisci dei valori di latitudine e longitudine validi.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ThemeColors.secondaryColor,
                                  textColor: ThemeColors.textColor,
                                  fontSize: 16.0
                              );
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.save_outlined),
                              SizedBox(width: 10),
                              Text(
                                'Salva',
                                style: TextStyle(color: ThemeColors.interactiveColor),
                              ),
                            ],
                          )),
                      TextButton(
                          onPressed: () async {
                            _locationService.flushPosition();
                            bool hasPermission = await _locationService.hasPermission();
                            if (hasPermission) {
                              Navigator.pushReplacementNamed(context, '/');
                            } else {
                              _locationService.openSettings();
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 10),
                              Text(
                                'Usa GPS',
                                style: TextStyle(color: ThemeColors.interactiveColor),
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ])));
  }
}
