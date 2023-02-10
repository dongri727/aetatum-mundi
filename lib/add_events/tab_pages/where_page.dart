import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/formats.dart';
import '../../domain/confirm.dart';

import 'dart:math' as math;


class WherePage extends StatefulWidget {
  const WherePage({Key? key}) : super(key: key);

  @override
  State<WherePage> createState() => _WherePageState();
}

class _WherePageState extends State<WherePage> {

  var newCountry = '';
  var newPlace = '';
  var newLatitude = 0.0;
  var newLongitude = 0.0;
  var newCountryAtThatTime = '';
  var newPlaceAtThatTime = '';
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  @override
  Widget build(BuildContext context) {
    final confirm = Provider.of<Confirm>(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/both.png'),
                  fit: BoxFit.cover,
                )
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [],
                    ),

                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TffFormat(
                                hintText: "Current Country Name",
                                onChanged: (text) {
                                  newCountry = text;
                                },
                                tffColor1: Colors.green,
                                tffColor2: Colors.lightGreen,
                              )
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TffFormat(
                                hintText: "Current Place Name",
                                onChanged: (text) {
                                  newPlace = text;
                                },
                                tffColor1: Colors.black54,
                                tffColor2: Colors.grey,
                              )
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TffFormat(
                                hintText: "Country Name at That Time",
                                onChanged: (text) {
                                  newCountryAtThatTime = text;
                                },
                                tffColor1: Colors.black54,
                                tffColor2: Colors.grey,
                              )
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TffFormat(
                                hintText: "Place Name at That Time",
                                onChanged: (text) {
                                  newPlaceAtThatTime = text;
                                },
                                tffColor1: Colors.black54,
                                tffColor2: Colors.grey,
                              )
                          ),
                        ],
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [

                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TffFormat(
                                hintText: "Latitude",
                                onChanged: (value) {
                                  newLatitude = double.tryParse(value)!;
                                },
                                tffColor1: Colors.black54,
                                tffColor2: Colors.grey,
                              )
                          ),


                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TffFormat(
                                hintText: "Longitude",
                                onChanged: (value) {
                                  newLongitude = double.tryParse(value)!;
                                },
                                tffColor1: Colors.black54,
                                tffColor2: Colors.grey,
                              )
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            double sn = (math.pi * newLatitude) / 180;
            double ew = (math.pi * newLongitude) / 180;
            x = math.cos(sn) * math.cos(ew);
            y = math.sin(sn);
            z = math.cos(sn) * math.sin(ew);
          });

          showDialog<void>(
              context: context,
              builder: (_){
                return AlertDialog(
                  title: const Text('Data has been temporarily stored.'),
                  content: const Text('They are not uploaded yet. please continue to fill in the other fields.'),
                  actions: <Widget>[
                    GestureDetector(
                      child: const Text('OK'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });

          confirm.country = newCountry;
          confirm.place = newPlace;
          confirm.countryAtThatTime = newCountryAtThatTime;
          confirm.placeAtThatTime = newPlaceAtThatTime;
          confirm.latitude = newLatitude;
          confirm.longitude = newLongitude;
          confirm.x = x;
          confirm.y = y;
          confirm.z = z;
          print(newCountry);
        },
        label: const Text('Temporarily Save'),
      ),
    );
  }
}