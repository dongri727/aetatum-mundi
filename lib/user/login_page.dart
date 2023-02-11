import 'package:flutter/material.dart';

import 'signup/signup_page.dart';
import 'signin/signin_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Row(
        children:  const [
          Expanded(
              flex: 1,
              child: SigninPage()
          ),
          Expanded(
              flex: 1,
              child: SignupPage()
          ),
        ],
      ),
    );
  }
}
