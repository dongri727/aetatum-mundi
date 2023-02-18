import 'package:flutter/material.dart';
import '../cover_page.dart';
import '../domain/custom_page_route.dart';


class ThreeDViewPage extends StatelessWidget {
  const ThreeDViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand( ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pointers.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              CustomPageRoute(
                const CoverPage(),
              ),
            );
          },
          child: const Text(
            "return",

          ),
        ),
      ),
    );
  }}
