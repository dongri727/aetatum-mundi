import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mysql_client/mysql_client.dart';

import '../../domain/.words.dart';
import '../../domain/formats.dart';
import 'confirm/confirm.dart';

import 'dart:math' as math;

import '../../domain/mundi_theme.dart';


class WherePage extends StatefulWidget {
  const WherePage({Key? key}) : super(key: key);

  @override
  State<WherePage> createState() => _WherePageState();
}

class _WherePageState extends State<WherePage> {

  var newPlace = '';
  var newLatitude = 0.0;
  var newLongitude = 0.0;
  var newATT = '';
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  String isSelectedPay = 'Universe';

  List<String> countries = <String>[
    'Universe',
    'MilkyWay',
    'SolarSystem',
    'TheEarth',
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo, DR',
    'Congo, Republic of the',
    'Cook Islands',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'East Timor',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Ivory Coast',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Niue',
    'North Korea',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Korea',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'St. Kitts and Nevis',
    'St. Lucia',
    'St. Vincent and the Grenadines',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'UAE',
    'Uganda',
    'Ukraine',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City',
    'Venezuela',
    'Viet Nam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
  ];

  List<Map<String, String>> displayListPlace = [];
  final List<String> _filtersPlace = <String>[];

  List<Map<String, String>> displayListATT = [];
  final List<String> _filtersATT = <String>[];
  

  Future<void> _place() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: HOST,
      port: PORT,
      userName: NAME,
      password: PASSWORD,
      databaseName: DATABASE,
    );

    await conn.connect();

    // select countries at that time involved
    var result = await conn.execute("SELECT id,place FROM Places ORDER BY place");

    // make list with query result
    List<Map<String, String>> placeList = [];
    for (final row in result.rows) {
      final data = {
        'selectedPlaced': row.colAt(0)!,
        'selectedPlace': row.colAt(1)!,
      };
      placeList.add(data);
    }

    setState(() {
      displayListPlace = placeList;
      
    });

    // close all connections
    await conn.close();
  }

  Future<void> _insertPlace() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: HOST,
      port: PORT,
      userName: NAME,
      password: PASSWORD,
      databaseName: DATABASE,
    );

    await conn.connect();

    // insert some rows to Place
    var res = await conn.execute(
      "INSERT INTO Places (id, place) VALUES (:id, :place)",
      <String, dynamic>{
        "id": null,
        "place": newPlace,
      },
    );

    print('Place inserted');

    // select countries involved
    var result = await conn.execute("SELECT id,place FROM Places ORDER BY place");

    // make list with query result
    List<Map<String, String>> placeList = [];
    for (final row in result.rows) {
      final data = {
        'selectedPlaceId': row.colAt(0)!,
        'selectedPlace': row.colAt(1)!,
      };
      placeList.add(data);
    }

    setState(() {
      displayListPlace = placeList;
    });

    // close all connections
    await conn.close();
  }

  Future<void> _att() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: HOST,
      port: PORT,
      userName: NAME,
      password: PASSWORD,
      databaseName: DATABASE,
    );

    await conn.connect();

    // select countries at that time involved
    var result = await conn.execute("SELECT id,att FROM AtThatTime ORDER BY att");

    // make list with query result
    List<Map<String, String>> attList = [];
    for (final row in result.rows) {
      final data = {
        'selectedATTId': row.colAt(0)!,
        'selectedATT': row.colAt(1)!,
      };
      attList.add(data);
    }

    setState(() {
      displayListATT = attList;
    });

    // close all connections
    await conn.close();
  }

  Future<void> _insertATT() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: HOST,
      port: PORT,
      userName: NAME,
      password: PASSWORD,
      databaseName: DATABASE,
    );

    await conn.connect();

    // insert some rows to ATT
    var res = await conn.execute(
      "INSERT INTO AtThatTime (id, att) VALUES (:id, :att)",
      <String, dynamic>{
        "id": null,
        "pays": newATT,
      },
    );

    print('ATT inserted');

    // select ATT involved
    var result = await conn.execute("SELECT id, att FROM AtThatTime ORDER BY att");

    // make list with query result
    List<Map<String, String>> attList = [];
    for (final row in result.rows) {
      final data = {
        'selectedATTId': row.colAt(0)!,
        'selectedATT': row.colAt(1)!,
      };
      attList.add(data);
    }

    setState(() {
      displayListATT = attList;
    });

    // close all connections
    await conn.close();
  }

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
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: HintText(hintText:
                          'Select Where it happened from the following'
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0x99e6e6fa),
                            ),
                            child: DropdownButton<String>(
                              value: isSelectedPay,
                              alignment: Alignment.center,
                              dropdownColor: const Color(0x99e6e6fa),
                              borderRadius: BorderRadius.circular(15.0),

                              onChanged: (String? value) {
                                setState(() {
                                  isSelectedPay = value!;
                                });
                              },
                              items: countries.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                      style: MundiTheme.textTheme.headlineMedium,
                                      value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TffFormat(
                              hintText: "Latitude",
                              onChanged: (value) {
                                newLatitude = double.tryParse(value)!;
                              },
                              tffColor1: Colors.black54,
                              tffColor2: const Color(0x99e6e6fa),
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
                              tffColor2: const Color(0x99e6e6fa),
                            )
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: OutlinedButton(
                              onPressed: _place,
                              child: const Text('Show and Select Current Place'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayListPlace.map<Widget>((data) {
                                return ChoiceChip(
                                  label: Text(data['selectedPlace'] ?? ""),
                                  selected: _filtersPlace.contains(data['selectedPlace']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        _filtersPlace.clear();
                                          _filtersPlace.add(data['selectedPlace']!);
                                      } else {
                                        _filtersPlace.removeWhere((String who) {
                                          return who == data[data['selectedPlace']]!;
                                        });
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TffFormat(
                              hintText: 'a New Place You Want',
                              onChanged: (text) {
                                newPlace = text;
                              },
                              tffColor1: Colors.black54,
                              tffColor2: const Color(0x99e6e6fa),
                            ),
                          ),
                          OutlinedButton (
                            onPressed: _insertPlace,
                            child: const Text('Add a New Place'),
                          )
                        ],
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: OutlinedButton(
                              onPressed: _att,
                              child: const Text('Show and Select Country, Place at that time'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayListATT.map<Widget>((data) {
                                return ChoiceChip(
                                  label: Text(data['selectedATT'] ?? ""),
                                  selected: _filtersATT.contains(data['selectedATT']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        _filtersATT.clear();
                                          _filtersATT.add(data['selectedATT']!);
                                      } else {
                                        _filtersATT.removeWhere((String who) {
                                          return who == data[data['selectedATT']]!;
                                        });
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TffFormat(
                              hintText: 'a New Country,Place at that time You Want',
                              onChanged: (text) {
                                newATT = text;
                              },
                              tffColor1: Colors.black54,
                              tffColor2: const Color(0x99e6e6fa),
                            ),
                          ),
                          OutlinedButton (
                            onPressed: _insertATT,
                            child: const Text('Add a New Country, Place at that time'),
                          )
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

          confirm.country = isSelectedPay;
          confirm.place = newPlace;
          confirm.att = newATT;
          confirm.latitude = newLatitude;
          confirm.longitude = newLongitude;
          confirm.x = x;
          confirm.y = y;
          confirm.z = z;
          print(isSelectedPay);
        },
        label: const Text('Temporarily Save'),
      ),
    );
  }
}