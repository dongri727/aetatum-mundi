import 'package:aetatum_mundi/domain/.words.dart';
import 'package:aetatum_mundi/read_search/update_page.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import '../domain/card_format.dart';


class DetailPage extends StatefulWidget {
  const DetailPage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {



  List<Map<String?, String?>> displayList = [];
  String? isSelectedCalendar = "BeforePresent";

  Future<void> _showDetail() async {
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
    var result = await conn.execute(
      //"SELECT * FROM $isSelectedCalendar WHERE id = $title");
        "SELECT * From commonEra where id = 10");

    List<Map<String?, String?>> list = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
        'selectedYear': row.colAt(1)!,
        'selectedName': row.colAt(2)!,
        'selectedCountry': row.colAt(3)!,
        'selectedPlace': row.colAt(4),
        'selectedLatitude': row.colAt(5),
        'selectedLongitude': row.colAt(6),
        'selectedDate': row.colAt(7),
        'selectedDateExcavation': row.colAt(9),
        'selectedCountryAtThatTime': row.colAt(11),
        'selectedPlaceAtThatTime': row.colAt(12),
        'selectedCategory': row.colAt(13),
        'selectedSubCategory': row.colAt(14),
        'selectedAnotherCategory': row.colAt(15),
        'selectedKeyPersonA': row.colAt(16),
        'selectedKeyPersonB': row.colAt(17),
        'selectedKeyWordA': row.colAt(18),
        'selectedKeyWordB': row.colAt(19),
        'selectedKeyWordC': row.colAt(20),
        'selectedKeyWordD': row.colAt(21),
        'selectedKeyWordE': row.colAt(22),
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
        title: const Text("detail"),
      ),
      body: Column(children: displayList.map<Widget>((data) {
        return Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGreenA(
                          textA: "Year",
                          textB: data['selectedYear']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGreenB(
                          textB: data['selectedName']?? "",
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGreenA(
                          textA: "country",
                          textB: data['selectedCountry']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "place",
                          textB: data['selectedPlace']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:  CardGrey(
                          textA: "lat",
                          textB: data['selectedLatitude']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "lon",
                          textB: data['selectedLongitude']?? "",
                        )
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "Date",
                          textB: data['selectedDate']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "date excavation",
                          textB: data['selectedDateExcavation']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "country ATT",
                          textB: data['selectedCountryAtThatTime']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "place ATT",
                          textB: data['selectedPlaceAtThatTime']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "category",
                          textB: data['selectedCategory']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "sub category",
                          textB: data['selectedSubCategory']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "another category",
                          textB: data['selectedAnotherCategory']?? "",
                        )
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardGrey(
                          textA: "key person A",
                          textB: data['selectedKeyPersonA']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:  CardGrey(
                          textA: "key person B",
                          textB: data['selectedKeyPersonB']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:  CardGrey(
                          textA: "key word A",
                          textB: data['selectedKeyWordA']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:   CardGrey(
                          textA: "key word B",
                          textB: data['selectedKeyWordB']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:   CardGrey(
                          textA: "key word C",
                          textB: data['selectedKeyWordC']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:   CardGrey(
                          textA: "key word D",
                          textB: data['selectedKeyWordD']?? "",
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:  CardGrey(
                          textA: "key word E",
                          textB: data['selectedKeyWordE']?? "",
                        )
                    ),
                  ],
                ),
              ),
            ]);}).toList()
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showDetail,
        tooltip: 'Show Detail',
        label: const Text("Show Detail"),
      ),
    );
  }
}