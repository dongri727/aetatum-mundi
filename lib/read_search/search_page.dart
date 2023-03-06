import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import '../domain/.words.dart';
import '../domain/formats.dart';
import '../domain/mundi_theme.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  //３つとか５つとかに増やせる

  var targetColumn1 = '';
  var targetColumn2 = '';
  var searchTerm1 = '';
  var searchTerm2 = '';
  var logique = '';

  List<Map<String?, dynamic>> displayList = [];

  String? isSelectedCalendar = 'BillionYears';

  Future<void> _Search() async {
    print("Connecting to mysql server...");

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: HOST,
      port: PORT,
      userName: NAME,
      password: PASSWORD,
      databaseName: DATABASE,
    );

    await conn.connect();

    print("Connected");


    var result = await conn.execute(
        "SELECT * FROM $isSelectedCalendar WHERE $targetColumn1 = '$searchTerm1' $logique $targetColumn2 = '$searchTerm2' ORDER BY year ASC");

    List<Map<String?, dynamic>> list = [];
    for (final row in result.rows) {
      final data = {
        'SelectedId': row.colAt(0)!,
        'SelectedYear': row.colAt(1)!,
        'SelectedName': row.colAt(2)!,
        'SelectedCountry': row.colAt(3)!
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

  List<String> periods = <String>[
    'BillionYears',
    'MillionYears',
    'ThousandYears',
    'YearsByDatingMethods',
    'HistoricalYears',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
            children:[
              Expanded(
                flex: 2,
                child: Column(
                    children: <Widget>[
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

                      Padding(
                          padding: const EdgeInsets.fromLTRB(50, 15, 50, 5),
                          child: TffFormat(
                            hintText: "column1",
                            onChanged: (text) {
                              targetColumn1 = text;
                            },
                            tffColor1: const Color(0xFF2f4f4f),
                            tffColor2: const Color(0x996b8e23),
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                          child: TffFormat(
                            hintText: "search term 1",
                            onChanged: (text) {
                              searchTerm1= text;
                            },
                            tffColor1: const Color(0xFF2f4f4f),
                            tffColor2: const Color(0x996b8e23),
                          )
                      ),

                      Padding(
                          padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                          child: TffFormat(
                            tffColor1: const Color(0xFF2f4f4f),
                            tffColor2: const Color(0x996b8e23),
                            hintText: "and / or",
                            onChanged: (text) {
                              logique = text;
                            },
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                          child: TffFormat(
                            hintText: "column2",
                            onChanged: (text) {
                              targetColumn2 = text;
                            },
                              tffColor1: const Color(0xFF2f4f4f),
                            tffColor2: const Color(0x996b8e23),
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                          child: TffFormat(
                            hintText: "search term 2",
                            onChanged: (text) {
                              searchTerm2= text;
                            },
                            tffColor1: const Color(0xFF2f4f4f),
                            tffColor2: const Color(0x996b8e23),
                          )
                      ),
                    ]),
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child:
                  Column(children: displayList.map<Widget>((data) {
                    return Card(
                        child: ListTile(
                          leading: Text(data['SelectedYear']?? ""),
                          title: Text(data['SelectedName']?? ""),
                          subtitle: Text(data['SelectedCountry']?? ""),
                          trailing: TextButton(
                            child: const Text("detail"),
                            onPressed: () {
                              Navigator.push<int>(
                                context,
                                MaterialPageRoute(builder: (context) => DetailPage(title: data['SelectedId']??"")),
                              );
                            },
                          ),
                        )
                    );
                  }
                  ).toList()
                  ),
                ),
              ),
            ]),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _Search,
        tooltip: 'Search',
        label: const Text("Search"),
      ),
    );
  }
}