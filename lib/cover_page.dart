import 'package:aetatum_mundi/index_page.dart';
import 'package:flutter/material.dart';
import 'domain/mundi_theme.dart';
import 'user/signin/signin_page.dart';

class CoverPage extends StatelessWidget {
  const CoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints.expand( ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cover.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: OutlinedButton(
               child: Text(
                        "Login",
                          style: MundiTheme.textTheme.bodyLarge,
                       ),
              onPressed: () {
                Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SigninPage(),
                  ),
                );
              }

            ),
          )
    );
  }
}

