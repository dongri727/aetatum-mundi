import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/confirm.dart';
import '../../../domain/formats.dart';
import 'confirm_model.dart';


class ConfirmPage extends StatelessWidget {
  const ConfirmPage({Key? key, required Confirm confirm})
      :_confirm = confirm,
        super(key: key);

  final Confirm _confirm;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmModel>(
      create: (_) => ConfirmModel(),
      child: Consumer<ConfirmModel>(
          builder: (_, model, __) {
            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () async {
                    await model.save(_confirm);
                  },
                  label: const Text('all right ?')),
              body: SafeArea(
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/both.png'),
                          fit: BoxFit.cover,
                        )
                    ),
                    child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children:  [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 50, 8, 8),
                                  child: ConfirmText(
                                      confirmText: '${_confirm.isSelectedCalendar}',
                                      confirmColor: const Color(0xFFF0E68C)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConfirmText(
                                      confirmText: '${_confirm.year}',
                                      confirmColor: const Color(0xFFF0E68C)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConfirmText(
                                      confirmText: '${_confirm.date}',
                                      confirmColor: const Color(0xFF8fbc8f)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConfirmText(
                                      confirmText: '${_confirm.dateExcavation}',
                                      confirmColor: const Color(0xFF8fbc8f)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConfirmText(
                                      confirmText: _confirm.name,
                                      confirmColor: const Color(0xFFF0E68C)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 50, 8, 8),
                                  child: ConfirmText(
                                      confirmText: _confirm.country,
                                      confirmColor: const Color(0xFFF0E68C)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConfirmText(
                                      confirmText: _confirm.place,
                                      confirmColor: const Color(0xFF8fbc8f)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConfirmText(
                                      confirmText: '${_confirm.latitude}',
                                      confirmColor: const Color(0xFF8fbc8f)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConfirmText(
                                      confirmText: '${_confirm.longitude}',
                                      confirmColor: const Color(0xFF8fbc8f)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConfirmText(
                                      confirmText: _confirm.countryAtThatTime,
                                      confirmColor: const Color(0xFF8fbc8f)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConfirmText(
                                      confirmText: _confirm.placeAtThatTime,
                                      confirmColor: const Color(0xFF8fbc8f)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SingleChildScrollView(
                                child:
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(150, 0, 150, 0),
                                    child: Card(color: const Color(0x99e6e6fa),
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title: Text('selectedWho'!),
                                          ),
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(150, 0, 150, 0),
                                    child: Card(color: const Color(0x99e6e6fa),
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title: Text('selecteTerm'!),
                                          ),
                                        )
                                    ),
                                  )
                                ]
                                )
                            ),
                          ),
                        ]
                    ),
                  )),
            );
          }),
    );
  }
}