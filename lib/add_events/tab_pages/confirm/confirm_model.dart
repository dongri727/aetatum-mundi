import 'package:flutter/foundation.dart';
import 'package:mysql_client/mysql_client.dart';

import '../../../domain/confirm.dart';
import '../../../domain/.words.dart';


class ConfirmModel extends ChangeNotifier {
  ConfirmModel();

  //insert into DB
  Future<void> save(Confirm confirm) async {
    if (kDebugMode) {
      print("Connecting to mysql server...");
    }

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: NAME,
      password: PASSWORD,
      databaseName: "aetatum", // optional
    );

    await conn.connect();

    if (kDebugMode) {
      print("Connected");
    }

    var period = confirm.isSelectedCalendar;

    // Insert main data into applicable period
    var resultEvent = await conn.execute(
      "INSERT INTO $period "
          "(id, annee, affair, country)"
          "VALUES (:id, :annee, :affair, :country)",
      <String, dynamic>{
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

    //if place data exist, insert place data into place table
    if(confirm.place != null || confirm.latitude != null || confirm.longitude != null) {
      var resultPlace = await conn.execute(
        "INSERT INTO Place "
            "(id, place, latitude, longitude, 3dx, 3dy, 3dz) "
            "VALUES (:id, :place, :latitude, :longitude, :3dx, :3dy, :3dz)",
        <String, dynamic>{
          "id": null,
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
      if (kDebugMode) {
        print(lastInsertedPlaceID);
      }

      // Insert $period_id and place_id into period-place table
      var resultPeriodPlace = await conn.execute(
        "INSERT INTO place$period (id, period_id, place_id) VALUE (:id, :period_id, :place_id)",
        <String, dynamic>{
          "id": null,
          "period_id": resultEvent.lastInsertID,
          "place_id": resultPlace.lastInsertID,
        },
      );

      //confirm PeriodPlace ID
      var lastInsertedPeriodPlaceID = resultPeriodPlace.lastInsertID;
      if (kDebugMode) {
        print(lastInsertedPeriodPlaceID);
      }
    }

    //if date data exist, insert date data into date table
    if(confirm.date != null || confirm.dateLocal != null) {
      var resultDate = await conn.execute(
          "INSERT INTO Date (id, date, dateLocal) VALUES (:id, :date, :dateLocal",
          <String, dynamic>{
            "id": null,
            "date": confirm.date,
            "dateLocal": confirm.dateLocal,
          }
      );
      //get date ID
      var lastInsertedDateID = resultDate.lastInsertID;
      if (kDebugMode) {
        print(lastInsertedDateID);
      }

      // Insert $period_id and date_id into period-date table
      var resultPeriodDate = await conn.execute(
          "INSERT INTO date$period (id, period_id, date.id) VALUES (:id, period_id ,date.id)",
          <String, dynamic>{
            "id": null,
            "period_id": resultEvent.lastInsertID,
            "date_id": resultDate.lastInsertID,
          }
      );
      //confirm PeriodDate ID
      var lastInsertedPeriodDateID = resultPeriodDate;
      if (kDebugMode) {
        print(lastInsertedPeriodDateID);
      }
    }
    
    // close all connections
    await conn.close();
  }

}