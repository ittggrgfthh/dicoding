import 'package:flutter/material.dart';
import 'package:project_akhir/second_tab_detail/ganjil_tab.dart';
import 'package:project_akhir/second_tab_detail/genap_tab.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const TabBar(
              tabs: [
                Tab(text: 'Semester Ganjil'),
                Tab(text: 'Semester Genap'),
              ],
            ),
          ),
          body: TabBarView(children: [
            GanjilTab(),
            GenapTab(),
          ]),
        ),
      );
}
