import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '.words.dart';

Future<void> showChips(
    BuildContext context,
    String sql,
    String id,
    String word,
    ) async {
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: NAME,
    password: PASSWORD,
    databaseName: "aetatum",
  );

  await conn.connect();

  // make query
  var result = await conn.execute(sql);

  // make list with query result
  List<Map<String, String>> listName = [];
  for (final row in result.rows) {
    final data = {
      id : row.colAt(0)!,
      word : row.colAt(1)!,
    };
    listName.add(data);
  }

  // close all connections
  await conn.close();

  //return listName;
}