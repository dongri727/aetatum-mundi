import 'package:flutter/material.dart';
import '3d_view_page.dart';
import 'add_events/tab_top.dart';
import 'domain/mundi_theme.dart';
import 'read_search/read_all_page.dart';
import 'read_search/search_page.dart';

class CoverPage extends StatelessWidget {
  const CoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints.expand( ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cover.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 300,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TabPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Register Events",
                            style: MundiTheme.textTheme.bodyLarge,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ThreeDViewPage(),
                              ),
                            );
                          },
                          child: Text(
                            "3D Space",
                            style: MundiTheme.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ReadAllPage(title: "Read and Update"),
                              ),
                            );
                          },
                          child: Text(
                            "Read & Update",
                            style: MundiTheme.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchPage(title: "Search"),
                              ),
                            );
                          },
                          child: Text(
                            "Search",
                            style: MundiTheme.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  )
              ),],
          )),);
  }

}

