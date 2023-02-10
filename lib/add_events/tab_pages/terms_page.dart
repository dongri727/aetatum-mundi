import 'package:aetatum_mundi/domain/.words.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:provider/provider.dart';

import '../../domain/formats.dart';
import '../../domain/confirm.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {

  List<Map<String, String>> displayList = [];
  final List<String> _filtersT = <String>[];

  Future<void> _term() async {
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
    var result = await conn.execute("SELECT * FROM term");

    // make list with query result
    List<Map<String, String>> list = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
        'selectedTerm': row.colAt(1)!,
      };
      list.add(data);
    }

    setState(() {
      displayList = list;
    });

    // close all connections
    await conn.close();
  }

  var newTerm = '';

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
      "INSERT INTO term (id, term) VALUES (:id, :term)",
      {
        "id": null, //if you set it auto increment
        "term": newTerm,
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
                            padding: const EdgeInsets.all(30.0),
                            child: TffFormat(
                              hintText: 'a new term you want',
                              onChanged: (text) {
                                newTerm = text;
                              },
                              tffColor1: Colors.black54,
                              tffColor2: Colors.grey,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: _insert,
                            child: const Text('Add a New Term'),
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
                              onPressed: _term,
                              child: const Text('Show Terms'),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayList.map<Widget>((data) {
                                return FilterChip(
                                  label: Text(data['selectedTerm']?? ""),
                                  selected: _filtersT.contains(data['selectedId']! + data['selectedTerm']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        if (!_filtersT.contains(data['selectedId']! + data['selectedTerm']!)) {
                                          _filtersT.add(data['selectedId']! + data['selectedTerm']!);
                                        }
                                      } else {
                                        _filtersT.removeWhere((String term) {
                                          return term == data['selectedId']! + data['selectedTerm']!;
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
                            'Selected: ${_filtersT.join(', ')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
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
          confirm.selectedTerm = _filtersT;
          confirm.selectedIdT = _filtersT;
          print("$_filtersT");
        },
        label: const Text('Temporarily Save'),
      ),
    );
  }
}