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

  List<Map<String, String>> displayListOrg = [];
  final List<String> _filtersOrg = <String>[];

  List<Map<String, String>> displayListWho = [];
  final List<String> _filtersWho = <String>[];

  Future<void> _orgInvolved() async {
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
    var result = await conn.execute("SELECT id, organization FROM Organizations ORDER BY organization");

    // make list with query result
    List<Map<String, String>> orgList = [];
    for (final row in result.rows) {
      final data = {
        'selectedOrgId': row.colAt(0)!,
        'selectedOrg': row.colAt(1)!,
      };
      orgList.add(data);
    }

    setState(() {
      displayListOrg = orgList;
    });

    // close all connections
    await conn.close();
  }

  var newOrg = '';

  Future<void> _insertOrg() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum",
    );

    await conn.connect();

    // insert some rows to Organization
    var res = await conn.execute(
      "INSERT INTO Organizations (id, organization) VALUES (:id, :organization)",
      <String, dynamic>{
        "id": null,
        "organization": newOrg,
      },
    );

    print('organization inserted');

    // select countries involved
    var result = await conn.execute("SELECT id, organization FROM Organizations ORDER BY organization");

    // make list with query result
    List<Map<String, String>> orgList = [];
    for (final row in result.rows) {
      final data = {
        'selectedOrgId': row.colAt(0)!,
        'selectedOrg': row.colAt(1)!,
      };
      orgList.add(data);
    }

    setState(() {
      displayListOrg = orgList;
    });

    // close all connections
    await conn.close();
  }


  Future<void> _whoInvolved() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum",
    );

    await conn.connect();

    // select person involved
    var result = await conn.execute("SELECT id, person FROM People ORDER BY person");

    // make list with query result
    List<Map<String, String>> whoList = [];
    for (final row in result.rows) {
      final data = {
        'selectedWhoId': row.colAt(0)!,
        'selectedWho': row.colAt(1)!,
      };
      whoList.add(data);
    }

    setState(() {
      displayListWho = whoList;
    });

    // close all connections
    await conn.close();
  }

  var newWho = '';

  Future<void> _insertWho() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum",
    );

    await conn.connect();

    // insert some rows to People
    var res = await conn.execute(
      "INSERT INTO People (id, person) VALUES (:id, :person)",
      <String, dynamic>{
        "id": null,
        "person": newWho,
      },
    );

    print('person inserted');

    // select person involved
    var result = await conn.execute("SELECT id, person FROM People ORDER BY person");

    // make list with query result
    List<Map<String, String>> whoList = [];
    for (final row in result.rows) {
      final data = {
        'selectedWhoId': row.colAt(0)!,
        'selectedWho': row.colAt(1)!,
      };
      whoList.add(data);
    }

    setState(() {
      displayListWho = whoList;
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
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: OutlinedButton(
                              onPressed: _orgInvolved,
                              child: const Text('Show and Select Organizations Involved'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayListOrg.map<Widget>((data) {
                                return FilterChip(
                                  label: Text(data['selectedOrg'] ?? ""),
                                  selected: _filtersOrg.contains(data['selectedOrg']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        if (!_filtersOrg.contains(data['selectedOrg']!)) {
                                          _filtersOrg.add(data['selectedOrg']!);
                                        }
                                      } else {
                                        _filtersOrg.removeWhere((String who) {
                                          return who == data[data['selectedOrg']]!;
                                        });
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Text(
                            'Selected: ${_filtersOrg.join(', ')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TffFormat(
                              hintText: 'a New Organization You Want',
                              onChanged: (text) {
                                newOrg = text;
                              },
                              tffColor1: Colors.black54,
                              tffColor2: const Color(0x99e6e6fa),
                            ),
                          ),
                          OutlinedButton (
                            onPressed: _insertOrg,
                            child: const Text('Add a New Organization'),
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
                              onPressed: _whoInvolved,
                              child: const Text('Show and Select People Involved'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayListWho.map<Widget>((data) {
                                return FilterChip(
                                  label: Text(data['selectedWho'] ?? ""),
                                  selected: _filtersWho.contains(data['selectedWho']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        if (!_filtersWho.contains(data['selectedWho']!)) {
                                          _filtersWho.add(data['selectedWho']!);
                                        }
                                      } else {
                                        _filtersWho.removeWhere((String who) {
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
                            'Selected: ${_filtersWho.join(', ')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TffFormat(
                              hintText: 'a New Person You Want',
                              onChanged: (text) {
                                newWho = text;
                              },
                              tffColor1: Colors.black54,
                              tffColor2: const Color(0x99e6e6fa),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: _insertWho,
                            child: const Text('Add a New Person'),
                          )
                          ],
              ),
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

          confirm.selectedOrg = _filtersOrg;
          confirm.selectedOrgId = _filtersOrg;
          print ("$_filtersOrg");

          confirm.selectedWho = _filtersWho;
          confirm.selectedWhoId = _filtersWho;
          print ("$_filtersWho");
        },
        label: const Text('Temporarily Save'),
      ),
    );
  }
}