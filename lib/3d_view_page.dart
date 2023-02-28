import 'package:flutter/material.dart';
import '../domain/custom_page_route.dart';
import 'index_page.dart';


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
            Navigator.push<String>(
              context,
              CustomPageRoute(
                const IndexPage(),
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
