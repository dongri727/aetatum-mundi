import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tab_pages/confirm/confirm.dart';
import 'tab_pages/pays_page.dart';
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
            child: const SafeArea(
              child: DefaultTabController(
                length: 7,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.white,
                      indicatorColor: Colors.yellow,
                      tabs: [
                        Tab(text: 'WHEN'),
                        Tab(text: 'WHAT'),
                        Tab(text: 'WHERE'),
                        Tab(text: 'PARTICIPANTS A'),
                        Tab(text: 'PARTICIPANTS B'),
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
                          PaysPage(),//関係国
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