import 'package:flutter/foundation.dart';
import 'package:mysql_client/mysql_client.dart';

import 'confirm.dart';
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
      databaseName: DATABASE,
    );

    await conn.connect();

    if (kDebugMode) {
      print("Connected");
    }

    var period = confirm.isSelectedCalendar;

    // Insert main data into applicable period
    var resultEvent = await conn.execute(
      "INSERT INTO $period "
          "(id, annee, affair, pays)"
          "VALUES (:id, :annee, :affair, :pays)",
      <String, dynamic>{
        "id": null,
        "annee": confirm.year,
        "affair": confirm.name,
        "pays": confirm.country,
        //"created-by": confirm.userID,
      },
    );

    // get period ID
    var lastInsertedPeriodID = resultEvent.lastInsertID;
    print(lastInsertedPeriodID);

    //if place data exist, insert place data into Places table
    if(confirm.place != null || confirm.latitude != null || confirm.longitude != null) {
      var resultPlace = await conn.execute(
        "INSERT INTO Places "
            "(id, place, latitude, longitude, 3dx, 3dy, 3dz) "
            "VALUES (:id, :place, :latitude, :longitude, :3dx, :3dy, :3dz)",
        <String, dynamic>{
          "id": null,
          "place": confirm.place,
          "att": confirm.att,
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

      // Insert $period_id and place_id into place$period table
      var resultPlacePeriod = await conn.execute(
        "INSERT INTO Places$period (id, periodId, placeId) VALUE (:id, :periodId, :placeId)",
        <String, dynamic>{
          "id": null,
          "periodId": resultEvent.lastInsertID,
          "placeId": resultPlace.lastInsertID,
        },
      );

      //confirm PlacePeriod ID
      var lastInsertedPlacePeriodID = resultPlacePeriod.lastInsertID;
      if (kDebugMode) {
        print(lastInsertedPlacePeriodID);
      }
    }

    //if date data exist, insert date data into date table
    if(confirm.date != null || confirm.dateLocal != null) {
      var resultDate = await conn.execute(
          "INSERT INTO Jour (id, date, dateLocal) VALUES (:id, :date, :dateLocal)",
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

      // Insert $periodId and dateId into jour$period table
      var resultDatePeriod = await conn.execute(
          "INSERT INTO Jour$period (id, periodId, dateId) VALUES (:id, periodId ,dateId)",
          <String, dynamic>{
            "id": null,
            "periodId": resultEvent.lastInsertID,
            "dateId": lastInsertedDateID,
          }
      );
      //confirm DatePeriod ID
      var lastInsertedDatePeriodID = resultDatePeriod;
      if (kDebugMode) {
        print(lastInsertedDatePeriodID);
      }
    }

    //country involved
    //todo Listを入力するのはこれでいいのか？
    if (confirm.selectedPays.isNotEmpty) {
      var resultPaysPeriod = await conn.execute(
          "INSERT INTO Pays$period (id, periodId, paysId) VALUES (:id, :periodId, :paysId)",
        <String, dynamic>{
            "id": null,
          "periodId": resultEvent.lastInsertID,
          "paysId": confirm.selectedPaysId,
        }
      );
      //confirm PayPeriod ID
      var lastInsertedPayPeriodID = resultPaysPeriod;
      if (kDebugMode) {
        print(lastInsertedPayPeriodID);
      }
    }

    //ATT involved
    //todo Listを入力するのはこれでいいのか？
    if (confirm.selectedATT.isNotEmpty) {
      var resultPaysPeriod = await conn.execute(
          "INSERT INTO AtThatTime$period (id, periodId, attId) VALUES (:id, :periodId, :attId)",
          <String, dynamic>{
            "id": null,
            "periodId": resultEvent.lastInsertID,
            "paysId": confirm.selectedATTId,
          }
      );
      //confirm PayPeriod ID
      var lastInsertedPayPeriodID = resultPaysPeriod;
      if (kDebugMode) {
        print(lastInsertedPayPeriodID);
      }
    }

    //organizations involved
    //todo Listを入力するのはこれでいいのか？
    if (confirm.selectedOrg.isNotEmpty) {
      var resultOrgPeriod = await conn.execute(
          "INSERT INTO pay$period (id, periodId, orgId) VALUES (:id, :periodId, :orgId)",
          <String, dynamic>{
            "id": null,
            "periodId": resultEvent.lastInsertID,
            "paysId": confirm.selectedOrgId,
          }
      );
      //confirm OrgPeriod ID
      var lastInsertedOrgPeriodID = resultOrgPeriod;
      if (kDebugMode) {
        print(lastInsertedOrgPeriodID);
      }
    }

    //people involved
    //todo Listを入力するのはこれでいいのか？
    if (confirm.selectedWho.isNotEmpty) {
      var resultWhoPeriod = await conn.execute(
          "INSERT INTO People$period (id, periodId, personId) VALUES (:id, :periodId, :personId)",
          <String, dynamic>{
            "id": null,
            "periodId": resultEvent.lastInsertID,
            "personId": confirm.selectedWhoId,
          }
      );
      //confirm WhoPeriod ID
      var lastInsertedWhoPeriodID = resultWhoPeriod;
      if (kDebugMode) {
        print(lastInsertedWhoPeriodID);
      }
    }

    //category
    //todo Listを入力するのはこれでいいのか？
    if (confirm.selectedCategory.isNotEmpty) {
      var resultWhoPeriod = await conn.execute(
          "INSERT INTO Categories$period (id, periodId, categoryId) VALUES (:id, :periodId, :categoryId)",
          <String, dynamic>{
            "id": null,
            "periodId": resultEvent.lastInsertID,
            "personId": confirm.selectedCategoryId,
          }
      );
      //confirm Category ID
      var lastInsertedCategoryPeriodID = resultWhoPeriod;
      if (kDebugMode) {
        print(lastInsertedCategoryPeriodID);
      }
    }

    //term
    //todo Listを入力するのはこれでいいのか？
    if (confirm.selectedTerm.isNotEmpty) {
      var resultTermPeriod = await conn.execute(
          "INSERT INTO Terms$period (id, periodId, termId) VALUES (:id, :periodId, :termId)",
          <String, dynamic>{
            "id": null,
            "periodId": resultEvent.lastInsertID,
            "termId": confirm.selectedTermId,
          }
      );
      //confirm OrgPeriod ID
      var lastInsertedTermPeriodID = resultTermPeriod;
      if (kDebugMode) {
        print(lastInsertedTermPeriodID);
      }
    }

    //ALL
    //todo 詳細表示を迅速にするための、すべてを一括管理するtableは必要か。
    var resultALLPeriod = await conn.execute(
        "INSERT INTO ALL$period (id, annee, afaire, pays, place, latitude, longitude, date, dateLocal,) "
            "VALUE (:id, :annee, :affair, :pays, :place, :latitude, :longitude, :date, :dateLocal)",
      <String, dynamic> {
        "id": null,
        "annee": confirm.year,
        "affair": confirm.name,
        "pays": confirm.country,
        "place": confirm.place,
        "latitude": confirm.latitude,
        "longitude": confirm.longitude,
        "date": confirm.date,
        "dateLocal": confirm.dateLocal,

      }
    );


    
    // close all connections
    await conn.close();
  }

}