import 'package:aetatum_mundi/domain/mundi_theme.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '../domain/.words.dart';
import 'update_page.dart';

class ReadAllPage extends StatefulWidget {
  const ReadAllPage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<ReadAllPage> createState() => _ReadAllPageState();
}

class _ReadAllPageState extends State<ReadAllPage> {

  List<Map<String, String>> displayList = [];
  String? isSelectedCalendar = "BceCe";

  Future<void> _readAll() async {
    print("Connecting to mysql server...");

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum",
    );

    await conn.connect();

    print("Connected");

    // make query
    var result = await conn.execute("SELECT * FROM $isSelectedCalendar ORDER BY annee ASC");

    // print some result data
    print(result.numOfColumns);
    print(result.numOfRows);

    // print query result
    List<Map<String, String>> list = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
        'selectedYear': row.colAt(1)!,
        'selectedName': row.colAt(2)!,
        'selectedCountry': row.colAt(3)!
      };
      list.add(data);
    }
    print('je suis la');

    setState(() {
      displayList = list;
    });

    // close all connections
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        //constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: DropdownButton(
                  alignment: Alignment.center,
                  dropdownColor: const Color(0x99e6e6fa),
                  borderRadius: BorderRadius.circular(15.0),
                  items: [
                    DropdownMenuItem(
                      value: 'BeforeSolarSystem',
                      child: Text(
                        'Before Solar System',
                        style: MundiTheme.textTheme.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'BeforeLife',
                      child: Text(
                        'Before Life',
                        style: MundiTheme.textTheme.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'BeforeHomos',
                      child: Text(
                        'Before Homos',
                        style: MundiTheme.textTheme.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'BeforePresent',
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
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child:
                  Column(children: displayList.map<Widget>((data) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(150, 0, 150, 0),
                      child: Card(color: const Color(0x99e6e6fa),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Text(data['selectedYear']?? ""),
                              title: Text(data['selectedName']?? ""),
                              subtitle: Text(data['selectedCountry']?? ""),
                              trailing: TextButton(
                                child: const Text("update"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => UpdatePage(title: data['selectedId']??"")),
                                  );
                                },
                              ),
                            ),
                          )
                      ),
                    );
                  }
                  ).toList()
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _readAll,
        tooltip: 'ReadAll',
        backgroundColor: Colors.blueGrey,
        label: const Text("read all"),
      ),
    );
  }
}