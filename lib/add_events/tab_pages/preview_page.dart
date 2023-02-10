import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/confirm.dart';
import 'confirm/confirm_model.dart';
import 'confirm/confirm_page.dart';


class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final confirm = Provider.of<Confirm>(context);
    return ChangeNotifierProvider<ConfirmModel>(
        create: (_) => ConfirmModel(),
        child: Consumer<ConfirmModel>(
          builder: (_, model, __) {
            return Scaffold(
              body: SafeArea(
                  child: Center(
                    child: Column(children: [
                      Expanded(
                          child: ConfirmPage(
                            confirm: confirm,
                          )),
                    ]),
                  )),
            );
          },
        ));
  }
}