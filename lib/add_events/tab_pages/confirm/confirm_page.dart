import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/card_format.dart';
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
                    showDialog<void>(
                        context: context,
                        builder: (_){
                          return AlertDialog(
                            title: const Text('Data has been archived.'),
                            content: const Text('thank you for the information'),
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
                                      confirmText: _confirm.dateLocal,
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

                          //TODO 各リストの内容を表示する
                          Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(150, 0, 150, 0),
                                child: GridView.builder(
                                  itemCount: _confirm.selectedTerm.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
                                  itemBuilder: (context, index) {
                                    return TermCard(
                                      _confirm.selectedTerm[index]
                                    );
                                  }
                                )
                              ),

                              const Padding(
                                padding: EdgeInsets.fromLTRB(150, 0, 150, 0),
                                child: Card(color: Color(0x99e6e6fa),
                                    elevation: 10,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: Text('selected terms'),
                                      ),
                                    )
                                ),
                              ),
                            ],
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