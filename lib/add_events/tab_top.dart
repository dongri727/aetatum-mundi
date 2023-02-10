import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/confirm.dart';
import 'tab_pages/preview_page.dart';
import 'tab_pages/terms_page.dart';
import 'tab_pages/what_page.dart';
import 'tab_pages/when_page.dart';
import 'tab_pages/where_page.dart';
import 'tab_pages/who_page.dart';


class TabPage extends StatelessWidget {
  const TabPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // 各タブページで参照するjournal を生成(プレビュー用に各タブ入力を保持する必要があるため)
          Provider(create: (context) => Confirm()),
        ],

        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Register an Event",
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/both.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: DefaultTabController(
                length: 6,
                child: Column(
                  children: const [
                    TabBar(
                      labelColor: Colors.white,
                      indicatorColor: Colors.yellow,
                      tabs: [
                        Tab(text: 'WHEN'),
                        Tab(text: 'WHAT'),
                        Tab(text: 'WHERE'),
                        Tab(text: 'PARTICIPANTS'),
                        Tab(text: 'SEARCH TERMS'),
                        Tab(text: 'CONFIRM',)

                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          WhenPage(), // いつ？
                          WhatPage(), // なにが？
                          WherePage(), // どこで？
                          WhoPage(), // だれ？
                          TermsPage(), // 検索語
                          PreviewPage(), // プレビュー
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}