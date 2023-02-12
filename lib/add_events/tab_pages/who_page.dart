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

  List<Map<String, String>> displayList = [];
  final List<String> _filtersP = <String>[];

  Future<void> _participants() async {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum",
    );

    await conn.connect();

    // make query
    var result = await conn.execute("SELECT * FROM Participants");

    // make list with query result
    List<Map<String, String>> list = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
        'selectedWho': row.colAt(1)!,
      };
      list.add(data);
    }

    setState(() {
      displayList = list;
    });

    // close all connections
    await conn.close();
  }

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
      {
        "id": null, //if you set it auto increment
        "participant": newWho,
      },
    );

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
                      children: [],
                    ),

                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: OutlinedButton(
                              onPressed: _participants,
                              child: const Text('Show Participants'),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayList.map<Widget>((data) {
                                return FilterChip(
                                  label: Text(data['selectedWho'] ?? ""),
                                  selected: _filtersP.contains(data['selectedId']! + data['selectedWho']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        if (!_filtersP.contains(data['selectedId']! + data['selectedWho']!)) {
                                          _filtersP.add(data['selectedId']! + data['selectedWho']!);
                                        }
                                      } else {
                                        _filtersP.removeWhere((String who) {
                                          return who == data['selectedId']! + data['selectedWho']! ;
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
                            'Selected: ${_filtersP.join(', ')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [

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

          confirm.selectedWho = _filtersP;
          confirm.selectedIdP = _filtersP;
          print ("$_filtersP");
        },
        label: const Text('Temporarily Save'),
      ),
    );
  }
}