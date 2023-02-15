import 'package:flutter/material.dart';

import '../read_search/update_page.dart';
import 'mundi_theme.dart';


class CardGreenA extends StatelessWidget {
  final String textA;
  final String textB;
  //final Function onTap;

  const CardGreenA({
    required this.textA,
    required this.textB,
    //required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightGreen[200],
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30,10,30,10),
                child: Text(
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    textA),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,30,10),
                child: Text(
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textB),
              )),
        ],
      ),
    );
  }
}

class CardGreenB extends StatelessWidget {
  //final String textA;
  final String textB;
  //final Function onPressed;

  const CardGreenB({
    //required this.textA,
    required this.textB,
    //required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.lightGreen[200],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30,10,30,10),
          child: Text(
              style: const TextStyle(
                fontSize: 20,
              ),
              textB),
        )
    );
  }
}

class CardGrey extends StatelessWidget {
  final String textA;
  final String textB;
  //final String textC;
  //final Function onTap;

  const CardGrey({
    required this.textA,
    required this.textB,
    //required this.textC,
    //required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30,10,30,10),
                child: Text(
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    textA),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,10,10),
                child: Text(
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textB),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,10,10),
                child: TextButton(
                  child: const Text("add"),
                  onPressed: () {
                    if (textB == "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UpdatePage(title: "")),
                      );
                    } else {null;}
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class TermCard extends StatelessWidget {
  TermCard(this.term, {super.key});
  String? term;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(term??"",
            style: MundiTheme.textTheme.bodyMedium),
      ),
    );
  }
}

