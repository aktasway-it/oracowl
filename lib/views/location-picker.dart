import 'package:astropills_tools/core/theme.colors.dart';
import 'package:astropills_tools/services/location.service.dart';
import 'package:astropills_tools/services/storage.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

import 'drawer.menu.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker();

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final _formKey = GlobalKey<FormBuilderState>();
  late List _savedLocations;
  LocationService _locationService = LocationService();
  StorageService _storageService = StorageService();

  @override
  void initState() {
    _savedLocations = _storageService.getData('saved-locations', []);
    print(_savedLocations);
    super.initState();
  }

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
              title: Text('pick_location').tr(),
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
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 90, 10, 0),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'locationName',
                          style: TextStyle(color: ThemeColors.textColor),
                          decoration: InputDecoration(
                              labelText: 'location_name'.tr(),
                              labelStyle: TextStyle(color: ThemeColors.primaryColor)),
                          keyboardType: TextInputType.text,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'latitude',
                                style: TextStyle(color: ThemeColors.textColor),
                                decoration: InputDecoration(
                                    labelText: 'latitude'.tr(),
                                    labelStyle: TextStyle(color: ThemeColors.primaryColor)),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'longitude',
                                style: TextStyle(color: ThemeColors.textColor),
                                decoration: InputDecoration(
                                    labelText: 'longitude'.tr(),
                                    labelStyle: TextStyle(color: ThemeColors.primaryColor)),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () {
                                  try {
                                    final locationName = _formKey
                                        .currentState!.fields['locationName']!.value.trim();
                                    if (locationName == '') {
                                      throw Exception();
                                    }
                                    final latitude = double.parse(_formKey
                                        .currentState!.fields['latitude']!.value);
                                    final longitude = double.parse(_formKey
                                        .currentState!.fields['longitude']!.value);

                                    _savedLocations.add({
                                      'name': locationName,
                                      'latitude': latitude,
                                      'longitude': longitude
                                    });
                                    _storageService.setData('saved-locations', _savedLocations);
                                    _locationService.createPositionFromLatLon(
                                        latitude, longitude);
                                    Navigator.pushReplacementNamed(context, '/');
                                  } catch(ex) {
                                    Fluttertoast.showToast(
                                        msg: "insert_valid_location".tr(),
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
                                      'save',
                                      style: TextStyle(color: ThemeColors.interactiveColor),
                                    ).tr(),
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
                                      'use_gps',
                                      style: TextStyle(color: ThemeColors.interactiveColor),
                                    ).tr(),
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Divider(height: 40, color: ThemeColors.textColor),
                Text(
                    'saved_locations',
                  style: TextStyle(
                    fontSize: 22,
                    color: ThemeColors.textColor,
                  )
                ).tr(),
                SizedBox(height: 20,),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                          itemCount: _savedLocations.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                tileColor: ThemeColors.primaryColor,
                                leading: TextButton(
                                  child: Icon(Icons.delete, size: 36, color: ThemeColors.secondaryColor),
                                  onPressed: () {
                                    _savedLocations.removeAt(index);
                                    _storageService.setData('saved-locations', _savedLocations);
                                    setState(() {});
                                  },
                                ),
                                onTap: () {
                                  _locationService.createPositionFromLatLon(
                                      _savedLocations[index]['latitude'], _savedLocations[index]['longitude']);
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                title: Text(
                                  _savedLocations[index]['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ThemeColors.interactiveColor,
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lat: ${_savedLocations[index]['latitude']}',
                                      style: TextStyle(
                                          color: ThemeColors.textColor,
                                          fontSize: 12
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Lon: ${_savedLocations[index]['longitude']}',
                                      style: TextStyle(
                                          color: ThemeColors.textColor,
                                          fontSize: 12
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                  ),
                )
              ],
            )
          ]))),
    );
  }
}
