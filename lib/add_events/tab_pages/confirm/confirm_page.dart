import 'package:aetatum_mundi/domain/mundi_theme.dart';
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
                        builder: (_) {
                          return AlertDialog(
                            title: const Text('Data has been archived.'),
                            content: const Text(
                                'thank you for the information'),
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
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: HintText(hintText:
                              '4 items required'
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                  confirmText: _confirm.name,
                                  confirmColor: const Color(0xFFF0E68C)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ConfirmText(
                                  confirmText: _confirm.country,
                                  confirmColor: const Color(0xFFF0E68C)),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: HintText(hintText:
                              'others option'
                              ),
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
                                  confirmText: _confirm.place,
                                  confirmColor: const Color(0xFF8fbc8f)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ConfirmText(
                                  confirmText: _confirm.att,
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

                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 50, 30, 8),
                              child: Text('Countries Involved',
                                  style: MundiTheme.textTheme.headlineSmall),
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    30, 8, 30, 8),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: _confirm.selectedPays.length,
                                    itemBuilder: (context, index) {
                                      return TermCard(
                                        _confirm.selectedPays[index],
                                      );
                                    }
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 50, 30, 8),
                              child: Text('Countries Involved at that time',
                                  style: MundiTheme.textTheme.headlineSmall),
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    30, 8, 30, 8),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: _confirm.selectedATT.length,
                                    itemBuilder: (context, index) {
                                      return TermCard(
                                        _confirm.selectedATT[index],
                                      );
                                    }
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 50, 30, 8),
                              child: Text('Organizations Involved',
                                  style: MundiTheme.textTheme.headlineSmall),
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    30, 8, 30, 8),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: _confirm.selectedOrg.length,
                                    itemBuilder: (context, index) {
                                      return TermCard(
                                        _confirm.selectedOrg[index],
                                      );
                                    }
                                )
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 50, 30, 8),
                            child: Text('People Involved',
                            style: MundiTheme.textTheme.headlineSmall),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30, 8, 30, 8),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _confirm.selectedWho.length,
                                  itemBuilder: (context, index) {
                                    return TermCard(
                                        _confirm.selectedWho[index],
                                    );
                                  }
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 50, 30, 8),
                            child: Text('Category',
                                style: MundiTheme.textTheme.headlineSmall),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30, 8, 30, 8),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _confirm.selectedCategory.length,
                                  //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  //  crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    return TermCard(
                                        _confirm.selectedCategory[index]
                                    );
                                  }
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 50, 30, 8),
                            child: Text('Search Terms',
                                style: MundiTheme.textTheme.headlineSmall),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30, 8, 30, 8),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _confirm.selectedTerm.length,
                                  itemBuilder: (context, index) {
                                    return TermCard(
                                      _confirm.selectedTerm[index],
                                    );
                                  }
                              )
                          ),
                        ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
          );
  }
}