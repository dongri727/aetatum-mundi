import 'dart:ffi';

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

    // Insert main data into applicable period
    var resultEvent = await conn.execute(
      "INSERT INTO $period "
          "(id, annee, affair, country, created-by)"
          "VALUES (:id, :annee, :affair, :country, :created-by)",
      {
        "id": null,
        "annee": confirm.year,
        "affair": confirm.name,
        "country": confirm.country,
        //"created-by": confirm.userID,
      },
    );

    // get period ID
    var lastInsertedPeriodID = resultEvent.lastInsertID;
    print(lastInsertedPeriodID);

    //Insert place data into place table
    var resultPlace = await conn.execute(
        "INSERT INTO place "
            "(id, place, latitude, longitude, 3dx, 3dy, 3dz) "
            "VALUES (:id, :place, :latitude, :longitude, :3dx, :3dy, :3dz)",
        {
          "id": nullptr,
          "place": confirm.place,
          "latitude": confirm.latitude,
          "longitude": confirm.longitude,
          "3dx": confirm.x,
          "3dy": confirm.y,
          "3dz": confirm.z,
        },
    );

    // get place ID
    var lastInsertedPlaceID = resultPlace.lastInsertID;
    print(lastInsertedPlaceID);

    // Insert periodId and placeId into period_place table
    var resultPP = await conn.execute(
        "INSERT INTO $period-place (id, $period.id, place.id) VALUE (:id, :$period.id, place.id)",
      {
        "id": null,
        "$period.id": resultEvent.lastInsertID,
        "place.id": resultPlace.lastInsertID,
      },
    );

    //confirm PP ID
    var lastInsertedPPID = resultPP.lastInsertID;
    print(lastInsertedPPID);

/*
    var result2 = await conn.execute(
        "INSERT INTO category"
            "id, "
    );

            "date": confirm.date,
        "dateExcavation": confirm.dateExcavation,
        "countryAtThatTime": confirm.countryAtThatTime,
         "placeAtThatTime": confirm.placeAtThatTime,
 */
    // close all connections
    await conn.close();
  }

}