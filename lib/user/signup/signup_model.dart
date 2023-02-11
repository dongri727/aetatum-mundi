import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '../../domain/.words.dart';

class SignupModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? username;
  String? email;
  String? password;

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future signUp() async {
    username = nameController.text;
    email = emailController.text;
    password = passwordController.text;

    if (username != null && email != null && password != null) {
      // usertableに登録
      Future<void> signup () async {
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

        // AddUser some rows
        var result = await conn.execute(
          "INSERT INTO user "
              "(id, username, email, password) "
              "VALUES (:id, :username, :email, :password)",
          {
            "id": null,
            "username": username,
            "email": email,
            "password": password,

          },
        );
      }
    }
  }
}