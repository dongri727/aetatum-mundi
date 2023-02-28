import 'package:aetatum_mundi/domain/.words.dart';
//import 'package:aetatum_mundi/domain/chips_format.dart';
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

  List<Map<String, String>> displayListTerm = [];
  final List<String> _filtersTerm = <String>[];

  List<Map<String, String>> displayListCategory = [];
  final List<String> _filtersCategory = <String>[];

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
    var result = await conn.execute("SELECT * FROM Terms ORDER BY term");

    // make list with query result
    List<Map<String, String>> listTerm = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
        'selectedTerm': row.colAt(1)!,
      };
      listTerm.add(data);
    }

    setState(() {
      displayListTerm = listTerm;
    });

    // close all connections
    await conn.close();
  }

  var newTerm = '';

  Future<void> _insertTerm() async {
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
    var resultTerm = await conn.execute(
      "INSERT INTO Terms (id, term) VALUES (:id, :term)",
      <String, dynamic>{
        "id": null, //if you set it auto increment
        "term": newTerm,
      },
    );

    // get period ID
    var lastInsertedTermID = resultTerm.lastInsertID;
    print(lastInsertedTermID);

    var result = await conn.execute("SELECT * FROM Terms ORDER BY term");

    // make list with query result
    List<Map<String, String>> listTerm = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
        'selectedTerm': row.colAt(1)!,
      };
      listTerm.add(data);
    }

    setState(() {
      displayListTerm = listTerm;
    });

    // close all connections
    await conn.close();
  }

  Future<void> _category() async {
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
    var result = await conn.execute("SELECT * FROM Categories ORDER BY category");

    // make list with query result
    List<Map<String, String>> listCategory = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
        'selectedCategory': row.colAt(1)!,
      };
      listCategory.add(data);
    }

    setState(() {
      displayListCategory = listCategory;
    });

    // close all connections
    await conn.close();
  }

  var newCategory = '';

  Future<void> _insertCategory() async {
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
    var resultCategory = await conn.execute(
      "INSERT INTO Categories (id, category) VALUES (:id, :category)",
      <String, dynamic>{
        "id": null, //if you set it auto increment
        "category": newCategory,
      },
    );

    // get last ID
    var lastInsertedCategoryID = resultCategory.lastInsertID;
    print(lastInsertedCategoryID);

    // make query
    var result = await conn.execute("SELECT * FROM Categories ORDER BY category");

    // make list with query result
    List<Map<String, String>> listCategory = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
        'selectedCategory': row.colAt(1)!,
      };
      listCategory.add(data);
    }

    setState(() {
      displayListCategory = listCategory;
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
                            onPressed: _category,
                            child: const Text('Show and Select Categories'),
                          ),
                        ),
                        Text(
                          'Selected: ${_filtersCategory.join(', ')}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.yellow,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            spacing: 5.0,
                            children: displayListCategory.map<Widget>((data) {
                              return FilterChip(
                                label: Text(data['selectedCategory']?? ""),
                                selected: _filtersCategory.contains(data['selectedCategory']!),
                                onSelected: (bool value) {
                                  setState(() {
                                    if (value) {
                                      if (!_filtersCategory.contains(data['selectedCategory']!)) {
                                        _filtersCategory.add(data['selectedCategory']!);
                                      }
                                    } else {
                                      _filtersCategory.removeWhere((String term) {
                                        return term == data['selectedCategory']!;
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
                            hintText: 'a New Category You Want',
                            onChanged: (text) {
                              newCategory = text;
                            },
                            tffColor1: Colors.black54,
                            tffColor2: const Color(0x99e6e6fa),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: _insertCategory,
                          child: const Text('Add a New Category'),
                        )
                      ],
                    ),
                  ),

                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: OutlinedButton(
                              onPressed: _term,
                              child: const Text('Show and Select Search Terms'),
                            ),
                          ),
                          Text(
                            'Selected: ${_filtersTerm.join(', ')}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5.0,
                              children: displayListTerm.map<Widget>((data) {
                                return FilterChip(
                                  label: Text(data['selectedTerm']?? ""),
                                  selected: _filtersTerm.contains(data['selectedTerm']!),
                                  onSelected: (bool value) {
                                    setState(() {
                                      if (value) {
                                        if (!_filtersTerm.contains(data['selectedTerm']!)) {
                                          _filtersTerm.add(data['selectedTerm']!);
                                        }
                                      } else {
                                        _filtersTerm.removeWhere((String term) {
                                          return term == data['selectedTerm']!;
                                        });
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(200, 30 ,200, 30),
                            child: TffFormat(
                              hintText: 'a New Search Term You Want',
                              onChanged: (text) {
                                newTerm = text;
                              },
                              tffColor1: Colors.black54,
                              tffColor2: const Color(0x99e6e6fa),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: _insertTerm,
                            child: const Text('Add a New Term'),
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
                  content: const Text('They are not uploaded yet. See the whole data in the next Page'),
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

          confirm.selectedTerm = _filtersTerm;
          confirm.selectedTermId = _filtersTerm;
          print("$_filtersTerm");

          confirm.selectedCategory = _filtersCategory;
          confirm.selectedCategoryId = _filtersCategory;
          print("$_filtersCategory");

        },
        label: const Text('Temporarily Save'),
      ),
    );
  }
}