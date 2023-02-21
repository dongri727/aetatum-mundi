import 'package:aetatum_mundi/domain/mundi_theme.dart';
import 'package:flutter/material.dart';

import 'signup_page.dart';

class AskSignupPage extends StatelessWidget {
  const AskSignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 20, 100),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: AssetImage('assets/images/right.png'),
                fit: BoxFit.cover,)
              ),
              child: Padding(padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text('if this is your first time',
                  style: MundiTheme.textTheme.headlineMedium),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: const Text('sign-up'))
                ],
              ),
              ),
            ),)
          ],
        ),
      ),
    );
  }
}
