import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/formats.dart';
import 'confirm/confirm.dart';

class WhatPage extends StatefulWidget {
  const WhatPage({Key? key}) : super(key: key);

  @override
  State<WhatPage> createState() => _WhatPageState();
}

class _WhatPageState extends State<WhatPage> {

  var newName= '';

  @override
  Widget build(BuildContext context) {
    final confirm = Provider.of<Confirm>(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/both.png'),
                  fit: BoxFit.cover,
                )
            ),
            alignment: Alignment.topCenter,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(300, 100, 300, 20),
                child: TffFormat(
                  hintText: "Event",
                  onChanged: (text) {
                    newName = text;
                  },
                    tffColor1: const Color(0xFF2f4f4f),
                    tffColor2: const Color(0x99e6e6fa),
                )
            ),
          )),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (_){
                return AlertDialog(
                  title: const Text('Data has been temporarily stored.'),
                  content: const Text('They are not uploaded yet. please continue to fill in the other fields.'),
                  actions: <Widget>[
                    GestureDetector(
                      child: const Text('OK'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });

          confirm.name = newName;
          print("save name");
        },
        label: const Text('Temporarily save'),
      ),

    );
  }
}