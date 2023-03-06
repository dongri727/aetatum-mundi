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
      host: HOST,
      port: PORT,
      userName: NAME,
      password: PASSWORD,
      databaseName: DATABASE,
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
        'allrId': row.colAt(0)!,
        'allAnnee': row.colAt(1)!,
        'allAffair': row.colAt(2)!,
        'allPays': row.colAt(3)!,
        'allATT': row.colAt(4),
        'allPlace': row.colAt(5),
        'allLatitude': row.colAt(6),
        'allLongitude': row.colAt(7),
        'allDate': row.colAt(8),
        'allDateLocal': row.colAt(9),
        'allPaysInvolved': row.colAt(10),
        'allATTInvolved': row.colAt(11),
        'allOrgInvolved': row.colAt(12),
        'allPeopleInvolved': row.colAt(13),
        'allCategory': row.colAt(14),
        'allTerm': row.colAt(15),
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
      body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/main.png'),
        fit: BoxFit.cover,
        ),
      ),
        child: Column(children: displayList.map<Widget>((data) {
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
                            textB: data['allAnnee']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGreenB(
                            textB: data['allAffair']?? "",
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGreenA(
                            textA: "country",
                            textB: data['allPays']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGrey(
                            textA: "place",
                            textB: data['allPlace']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child:  CardGrey(
                            textA: "lat",
                            textB: data['allLatitude']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGrey(
                            textA: "lon",
                            textB: data['allLongitude']?? "",
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
                            textB: data['allDate']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGrey(
                            textA: "date local",
                            textB: data['allDateLocal']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGrey(
                            textA: "country involved",
                            textB: data['allPayInvolved']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGrey(
                            textA: "country involved at that time",
                            textB: data['allATTInvolved']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGrey(
                            textA: "Organization involved",
                            textB: data['allCategory']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGrey(
                            textA: "people involved",
                            textB: data['allSubCategory']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CardGrey(
                            textA: "category",
                            textB: data['allCategory']?? "",
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
                            textA: "search terms",
                            textB: data['allTerm']?? "",
                          )
                      ),
                      /*
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child:  CardGrey(
                            textA: "key person B",
                            textB: data['allKeyPersonB']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child:  CardGrey(
                            textA: "key word A",
                            textB: data['allKeyWordA']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child:   CardGrey(
                            textA: "key word B",
                            textB: data['allKeyWordB']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child:   CardGrey(
                            textA: "key word C",
                            textB: data['allKeyWordC']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child:   CardGrey(
                            textA: "key word D",
                            textB: data['allKeyWordD']?? "",
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child:  CardGrey(
                            textA: "key word E",
                            textB: data['allKeyWordE']?? "",
                          )
                      ),

                       */
                    ],
                  ),
                ),
              ]);}).toList()
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showDetail,
        tooltip: 'Show Detail',
        label: const Text("Show Detail"),
      ),
    );
  }
}