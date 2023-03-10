import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/formats.dart';
import '../../domain/mundi_theme.dart';
import 'confirm/confirm.dart';



class WhenPage extends StatefulWidget {
  const WhenPage({Key? key}) : super(key: key);

  @override
  State<WhenPage> createState() => _WhenPageState();
}

class _WhenPageState extends State<WhenPage> {

  var newYear = 0;
  var newDate = 0;
  var newDateLocal = "";

  String? isSelectedCalendar = 'HistoricalYears';

  List<String> periods = <String>[
    'BillionYears',
    'MillionYears',
    'ThousandYears',
    'YearsByDatingMethods',
    'HistoricalYears',
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
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: HintText(hintText:
                          'Select a format from the following'
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
                              value: isSelectedCalendar,
                              alignment: Alignment.center,
                              dropdownColor: const Color(0xCCe6e6fa),
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
                              tffColor2: const Color(0x99e6e6fa),
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
                              tffColor2: const Color(0x99e6e6fa),
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
                            tffColor2: const Color(0x99e6e6fa),
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
                                'Ex: -13.8 (as Billion years) \n as Big Bang'),
                            const HintText(hintText:
                                'Ex: -3200 (as Million years) \n as Cyanobacteria'),
                            const HintText(hintText:
                                'Ex: -3180 (as Thousand years)\n as Lucy (Australopithecus)'),
                            const HintText(hintText:
                                'Ex: -9500 by dating methods\n as Gobekli Tepe'),
                            const HintText(hintText:
                                'Ex: -766 \n as The Ancient Olympic Game'),
                            const HintText(hintText:
                                'Ex: 1169 \n as Apollo11 was launched \n'
                            ),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              style: MundiTheme.textTheme.bodyLarge,
                              'Month-Date',
                            ),
                          ),
                          const HintText(hintText:
                          ''),
                          const HintText(hintText:
                          ''),
                          const HintText(hintText:
                          ''),
                        ],
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