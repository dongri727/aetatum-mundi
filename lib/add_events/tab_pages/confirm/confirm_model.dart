import 'dart:ffi';
import 'dart:io';

import 'package:mysql_client/mysql_client.dart';
import 'package:flutter/material.dart';

import '../../../domain/confirm.dart';
import '../../../domain/.words.dart';


class ConfirmModel extends ChangeNotifier {
  ConfirmModel();

  //insert into DB
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
          "(id, annee, affair, country)"
          "VALUES (:id, :annee, :affair, :country)",
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
        "INSERT INTO Place "
            "(id, place, countryAtThatTime, placeAtThatTime, latitude, longitude, 3dx, 3dy, 3dz) "
            "VALUES (:id, :place, :countryAtThatTime, :placeAtThatTime, :latitude, :longitude, :3dx, :3dy, :3dz)",
        {
          "id": null,
          "place": confirm.place,
          "countryAtThatTime": confirm.countryAtThatTime,
          "placeAtThatTime": confirm.placeAtThatTime,
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


    // Insert $period_id and place_id into period-place table
    var resultPeriodPlace = await conn.execute(
        "INSERT INTO place$period (id, period_id, place_id) VALUE (:id, :period_id, :place_id)",
      {
        "id": null,
        "period_id": resultEvent.lastInsertID,
        "place_id": resultPlace.lastInsertID,
      },
    );

    //confirm PeriodPlace ID
    var lastInsertedPeriodPlaceID = resultPeriodPlace.lastInsertID;
    print(lastInsertedPeriodPlaceID);

    //Insert date data into date table
    var resultDate = await conn.execute(
        "INSERT INTO Date (id, date) VALUES (:id, :date)",
      {
        "id": null,
        "date": confirm.date,
      }
    );

    //get date ID
    var lastInsertedDateID = resultDate.lastInsertID;
    print(lastInsertedDateID);

    // Insert $period_id and date_id into period-date table
    var resultPeriodDate = await conn.execute(
        "INSERT INTO date$period (id, period_id, date.id) VALUES (:id, period_id ,date.id)",
      {
        "id": null,
        "period_id": resultEvent.lastInsertID,
        "date_id": resultDate.lastInsertID,
      }
    );

    //confirm PeriodDate ID
    var lastInsertedPeriodDateID = resultPeriodDate;
    print(lastInsertedPeriodDateID);

    // close all connections
    await conn.close();
  }

}