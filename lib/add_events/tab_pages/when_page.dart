import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/formats.dart';
import '../../domain/mundi_theme.dart';
import '../../domain/confirm.dart';



class WhenPage extends StatefulWidget {
  const WhenPage({Key? key}) : super(key: key);

  @override
  State<WhenPage> createState() => _WhenPageState();
}

class _WhenPageState extends State<WhenPage> {

  var newYear = 0;
  var newDate = 0;
  var newDateLocal = "";

  String? isSelectedCalendar = 'Select a period from the following';

  List<String> periods = <String>[
    'Select a period from the following',
    'Universe Before Solar System',
    'Solar System before Life of the Earth',
    'The Earth Before K-Pg Boundary',
    'Before Hominina'
    'Before Present',
    'Historical Period',
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
                              value: isSelectedCalendar,
                              alignment: Alignment.center,
                              dropdownColor: const Color(0x99e6e6fa),
                              borderRadius: BorderRadius.circular(15.0),

                              onChanged: (String? value) {
                                setState(() {
                                  isSelectedCalendar = value;
                                });
                              },
                              items: periods.map<DropdownMenuItem<String>>((String value){
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
                        const HintText(hintText:
                        'World Calendar'
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TffFormat(
                              hintText: "year (required)",
                              onChanged: (value) {
                                newYear = int.parse(value);
                              },
                              tffColor1: Colors.black54,
                              tffColor2: const Color(0x996b8e23),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TffFormat(
                              hintText: "month-date as 0131 (option)",
                              onChanged: (value) {
                                newDate = int.parse(value);
                              },
                              tffColor1: Colors.black54,
                              tffColor2: const Color(0x66808080),
                            ),
                        ),

                        const HintText(hintText:
                        'Other Calendars'
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TffFormat(
                            hintText: "ex: Hijura year-month-date (option)",
                            onChanged: (text) {
                              newDateLocal = text;
                            },
                            tffColor1: Colors.black54,
                            tffColor2: const Color(0x66808080),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(60, 20, 60, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  style: MundiTheme.textTheme.bodyLarge,
                                'YEAR',
                              ),
                            ),
                            const HintText(hintText:
                                'Ex: -13.8 (as a Billion years) \n as Big Bang \n In Universe before Solar System ',
                            ),
                            const HintText(hintText:
                                'Ex: -4540 (as a Million years)\n as The Earth is Born \n In Before Life of the Earth ',
                            ),
                            const HintText(hintText:
                                'Ex: -3200 (as a Million years) \n as Cyanobacteria \n In Before K-Pg Boundary'
                            ),
                            const HintText(hintText:
                                'Ex: -3180 (as a Thousand years)\n as Lucy (Australopithecus) \n In Before Holocene'
                            ),
                            const HintText(hintText:
                                'Ex: -9500 \n as Gobekli Tepe \n In Holocene'
                            ),
                            const HintText(hintText:
                                'Ex: -766 \n as The Ancient Olympic Game \n In Historical Period'
                            ),
                            const HintText(hintText:
                                'Ex: 1169 \n as Apollo11 was launched \n in Historical Period'
                            ),


                          ],
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [],
                      )
                  ),
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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

          confirm.year = newYear;
          confirm.date = newDate;
          confirm.dateLocal = newDateLocal;
          confirm.isSelectedCalendar = isSelectedCalendar;
          print("save when");
        },
        label: const Text('Keep Temporarily'),
      ),
    );
  }
}