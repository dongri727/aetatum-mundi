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
  var newDateExcavation = 0;

  String? isSelectedCalendar = "";

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
                          child:  DropdownButton(
                            alignment: Alignment.center,
                            dropdownColor: const Color(0x99e6e6fa),
                            borderRadius: BorderRadius.circular(15.0),
                            items: [
                              DropdownMenuItem(
                                value: '',
                                child: Text(
                                  'Select a period from the following',
                                  style: MundiTheme.textTheme.bodyLarge,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'BeforeSolarSystem',
                                child: Text(
                                  'Universe Before Solar System',
                                  style: MundiTheme.textTheme.bodyMedium,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'BeforeLife',
                                child: Text(
                                  'Solar System before Life of the Earth',
                                  style: MundiTheme.textTheme.bodyMedium,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'BeforeKPgBoundary',
                                child: Text(
                                  'Before K-Pg Boundary',
                                  style: MundiTheme.textTheme.bodyMedium,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Events by Carbon ',
                                child: Text(
                                  'Before Present',
                                  style: MundiTheme.textTheme.bodyMedium,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'BceCe',
                                child: Text(
                                  'Before Common Era, Common Era',
                                  style: MundiTheme.textTheme.bodyMedium,
                                ),
                              ),

                            ], onChanged: (String? value) {
                            setState(() {
                              isSelectedCalendar = value;
                            });
                          },
                            value: isSelectedCalendar,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TffFormat(
                              hintText: "year (required)",
                              onChanged: (value) {
                                newYear = int.parse(value);
                              },
                              tffColor1: const Color(0xFF2f4f4f),
                              tffColor2: const Color(0xFF6b8e23),
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
                              tffColor2: Colors.grey,
                            )
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [],
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
          confirm.dateExcavation = newDateExcavation;
          confirm.isSelectedCalendar = isSelectedCalendar;
          print("save when");
        },
        label: const Text('Keep Temporarily'),
      ),
    );
  }
}