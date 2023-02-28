import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:provider/provider.dart';

import '../../domain/.words.dart';
import '../../domain/formats.dart';
import '../../domain/confirm.dart';

class PaysPage extends StatefulWidget {
  const PaysPage({Key? key}) : super(key: key);

  @override
  State<PaysPage> createState() => _PaysPageState();
}

class _PaysPageState extends State<PaysPage> {

  List<Map<String, String>> displayListPays = [];
  final List<String> _filtersPays = <String>[];

  List<Map<String, String>> displayListATT = [];
  final List<String> _filtersATT = <String>[];

  Future<void> _paysInvolved() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum",
    );

    await conn.connect();

    // select countries pays involved
    var result = await conn.execute("SELECT id,pays FROM Pays");

    // make list with query result
    List<Map<String, String>> paysList = [];
    for (final row in result.rows) {
      final data = {
        'selectedPaysId': row.colAt(0)!,
        'selectedPays': row.colAt(1)!,
      };
      paysList.add(data);
    }

    setState(() {
      displayListPays = paysList;
    });

    // close all connections
    await conn.close();
  }


  Future<void> _attInvolved() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum",
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

  var newATT = '';

  Future<void> _insertATT() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum",
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

    // select countries involved
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: OutlinedButton(
                                  onPressed: _paysInvolved,
                                  child: const Text('Show and Select Countries Involved'),
                                ),
                              ),
                              Text(
                                'Selected: ${_filtersPays.join(', ')}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.yellow,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  spacing: 5.0,
                                  children: displayListPays.map<Widget>((data) {
                                    return FilterChip(
                                      label: Text(data['selectedPays'] ?? ""),
                                      selected: _filtersPays.contains(data['selectedPays']!),
                                      onSelected: (bool value) {
                                        setState(() {
                                          if (value) {
                                            if (!_filtersPays.contains(data['selectedPays']!)) {
                                              _filtersPays.add(data['selectedPays']!);
                                            }
                                          } else {
                                            _filtersPays.removeWhere((String who) {
                                              return who == data[data['selectedPays']]!;
                                            });
                                          }
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: OutlinedButton(
                                  onPressed: _attInvolved,
                                  child: const Text('Show and Select Countries Involved at that time'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  spacing: 5.0,
                                  children: displayListATT.map<Widget>((data) {
                                    return FilterChip(
                                      label: Text(data['selectedATT'] ?? ""),
                                      selected: _filtersATT.contains(data['selectedATT']!),
                                      onSelected: (bool value) {
                                        setState(() {
                                          if (value) {
                                            if (!_filtersATT.contains(data['selectedATT']!)) {
                                              _filtersATT.add(data['selectedATT']!);
                                            }
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
                              Text(
                                'Selected: ${_filtersATT.join(', ')}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.yellow,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: TffFormat(
                                  hintText: 'a New Country Involved at that time You Want',
                                  onChanged: (text) {
                                    newATT = text;
                                  },
                                  tffColor1: Colors.black54,
                                  tffColor2: const Color(0x99e6e6fa),
                                ),
                              ),
                              OutlinedButton (
                                onPressed: _insertATT,
                                child: const Text('Add a New Country Involved at that time'),
                              )
                            ],
                          )
                      ),

                    ]
                )
            )),),
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

          confirm.selectedPays = _filtersPays;
          confirm.selectedPaysId = _filtersPays;
          print ("$_filtersPays");

          confirm.selectedATT = _filtersATT;
          confirm.selectedATTId = _filtersATT;
          print ("$_filtersATT");

        },
        label: const Text('Temporarily Save'),
      ),
    );
  }
}