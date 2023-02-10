import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/formats.dart';
import '../../domain/confirm.dart';

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
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                        child: TffFormat(
                          hintText: "Event",
                          onChanged: (text) {
                            newName = text;
                          },
                          tffColor1: Colors.green,
                          tffColor2: Colors.lightGreen,
                        )
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [],
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [],
                      )
                  ),
                ],
              ),
            ),
          )),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (newName == "") {
            throw "Name Required";
          }
          confirm.name = newName;
          print("save name");
        },
        label: const Text('Temporarily save'),
      ),

    );
  }
}