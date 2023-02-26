import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:provider/provider.dart';

import '../../domain/.words.dart';
import '../../domain/formats.dart';
import '../../domain/confirm.dart';

class WhoPage extends StatefulWidget {
  const WhoPage({Key? key}) : super(key: key);

  @override
  State<WhoPage> createState() => _WhoPageState();
}

class _WhoPageState extends State<WhoPage> {

  List<Map<String, String>> displayListPays = [];
  final List<String> _filtersPays = <String>[];

  List<Map<String, String>> displayListOrg = [];
  final List<String> _filtersOrg = <String>[];

  List<Map<String, String>> displayListWho = [];
  final List<String> _filtersWho = <String>[];

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

    // select countries involved
    var result = await conn.execute("SELECT id,pays FROM Pays");

    // make list with query result
    List<Map<String, String>> paysList = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
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
/*
  var newWho = '';

  Future<void> _insert() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum",
    );

    await conn.connect();

    // insert some rows
    var res = await conn.execute(
      "INSERT INTO Participants (id, participant) VALUES (:id, :participant)",
      <String, dynamic>{
        "id": null,
        "participant": newWho,
      },
    );

    // close all connections
    await conn.close();
  }

 */

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
                              child: const Text('Show Pays Involved'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayListPays.map<Widget>((data) {
                                return FilterChip(
                                  label: Text(data['selectedPays'] ?? ""),
                                  //selected: _filtersP.contains(data['selectedId']! + data['selectedWho']!),
                                  selected: _filtersPays.contains(data['selectedPays']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        if (!_filtersPays.contains(data['selectedPays']!)) {
                                          _filtersPays.add(data['selectedPay']!);
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
                          Text(
                            'Selected: ${_filtersPays.join(', ')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
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
                          /*
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: OutlinedButton(
                              onPressed: _payInvolved,
                              child: const Text('Show Participants'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayListPay.map<Widget>((data) {
                                return FilterChip(
                                  label: Text(data['selectedWho'] ?? ""),
                                  //selected: _filtersP.contains(data['selectedId']! + data['selectedWho']!),
                                  selected: _filtersPay.contains(data['selectedWho']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        if (!_filtersPay.contains(data['selectedWho']!)) {
                                          _filtersPay.add(data['selectedWho']!);
                                        }
                                      } else {
                                        _filtersPay.removeWhere((String who) {
                                          return who == data[data['selectedWho']]!;
                                        });
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Text(
                            'Selected: ${_filtersPay.join(', ')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayListPay.map<Widget>((data) {
                                return FilterChip(
                                  label: Text(data['selectedWho'] ?? ""),
                                  //selected: _filtersP.contains(data['selectedId']! + data['selectedWho']!),
                                  selected: _filtersPay.contains(data['selectedWho']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        if (!_filtersPay.contains(data['selectedWho']!)) {
                                          _filtersPay.add(data['selectedWho']!);
                                        }
                                      } else {
                                        _filtersPay.removeWhere((String who) {
                                          return who == data[data['selectedWho']]!;
                                        });
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Selected: ${_filtersPay.join(', ')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                            ),

                          ),

                           */
                        ],
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
/*
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TffFormat(
                              hintText: 'a new participant you want',
                              onChanged: (text) {
                                newWho = text;
                              },
                              tffColor1: Colors.black54,
                              tffColor2: Colors.grey,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: _insert,
                            child: const Text('Add a New Participant'),
                          )
                        ],
                      )
                  ),

 */
                ],
              ),
            ),
            ]))
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

          confirm.selectedWho = _filtersPays;
          confirm.selectedWhoId = _filtersPays;
          print ("$_filtersPays");
        },
        label: const Text('Temporarily Save'),
      ),
    );
  }
}