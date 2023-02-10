import 'package:mysql_client/mysql_client.dart';
import 'package:flutter/material.dart';

import '../../../domain/confirm.dart';
import '../../../domain/.words.dart';


class ConfirmModel extends ChangeNotifier {
  ConfirmModel();

  //データベースに保存
  Future<void> save(Confirm confirm) async {
    print("Connecting to mysql server...");

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum", // optional
    );

    await conn.connect();

    print("Connected");

    var period = confirm.isSelectedCalendar;

    // AddFact some rows
    var result = await conn.execute(
      "INSERT INTO $period "
          "(id, annee, affair, country) "
          "VALUES (:id, :annee, :affair, :country)",
      {
        "id": null,
        "annee": confirm.year,
        "affair": confirm.name,
        "country": confirm.country,
        /*
        "place": confirm.place,
        "latitude": confirm.latitude,
        "longitude": confirm.longitude,
        "x": confirm.x,
        "y": confirm.y,
        "z": confirm.z,
        "date": confirm.date,
        "dateExcavation": confirm.dateExcavation,
        "countryAtThatTime": confirm.countryAtThatTime,
        "placeAtThatTime": confirm.placeAtThatTime,

         */
      },
    );

    // Get the ID of the last inserted row.
    var lastInsertedID = result.lastInsertID;
    print(lastInsertedID);
/*
    var result2 = await conn.execute(
        "INSERT INTO category"
            "id, "
    );
 */
    // close all connections
    await conn.close();
  }

}