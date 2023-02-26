import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/formats.dart';
import '../../domain/confirm.dart';
import '../../domain/country.dart';

import 'dart:math' as math;

import '../../domain/mundi_theme.dart';


class WherePage extends StatefulWidget {
  const WherePage({Key? key}) : super(key: key);

  @override
  State<WherePage> createState() => _WherePageState();
}

class _WherePageState extends State<WherePage> {

  //var newCountry = '';
  var newPlace = '';
  var newLatitude = 0.0;
  var newLongitude = 0.0;
  var newCountryAtThatTime = '';
  var newPlaceAtThatTime = '';
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  String isSelectedPay = 'Where did it happened ?';

  List<String> countries = <String>[
    'Where did it happened ?',
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
                                      style: MundiTheme.textTheme.bodyMedium,
                                      value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          /*
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TffFormat(
                                hintText: "Current Country Name",
                                onChanged: (text) {
                                  newCountry = text;
                                },
                                tffColor1: const Color(0xFF2f4f4f),
                                tffColor2: const Color(0xFF6b8e23),
                              )
                          ),
                           */
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

          confirm.country = isSelectedPay;
          confirm.place = newPlace;
          confirm.countryAtThatTime = newCountryAtThatTime;
          confirm.placeAtThatTime = newPlaceAtThatTime;
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