import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import '../domain/.words.dart';
import '../domain/formats.dart';


class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var res = '';
  var targetId = '';
  var targetTerm = '';
  var newTerm = '';

  Future<void> _update() async {
    print("Connecting to mysql server...");

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: HOST,
      port: PORT,
      userName: NAME,
      password: PASSWORD,
      databaseName: DATABASE, // optional
    );

    await conn.connect();

    print("Connected");

    // update some rows
    var res = await conn.execute(
      "UPDATE BceCe SET $targetTerm = :$targetTerm WHERE id = $targetId",
      <String, dynamic>{
        targetTerm: newTerm,
      },
    );

    print(res.affectedRows);


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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Row(
            children: [
              const Expanded(
                  flex: 1,
                  child: Column(
                    children: [],
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: TffFormat(
                          hintText: 'id',
                          onChanged: (text) {
                            targetId = text;
                          },
                          tffColor1: Colors.green,
                          tffColor2: Colors.lightGreen,
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: TffFormat(
                          hintText: "term",
                          onChanged: (text) {
                            targetTerm = text;
                          },
                          tffColor1: Colors.green,
                          tffColor2: Colors.lightGreen,
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: TffFormat(
                          hintText: "new term",
                          onChanged: (text) {
                            newTerm = text;
                          },
                          tffColor1: Colors.green,
                          tffColor2: Colors.lightGreen,
                        )
                    ),
                    const Text(
                      'Push button to update',
                    ),
                  ],
                ),
              ),
              const Expanded(
                  flex: 1,
                  child: Column(
                    children: [],
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _update,
        tooltip: 'update',
        label: const Text("update"),
      ),
    );
  }
}