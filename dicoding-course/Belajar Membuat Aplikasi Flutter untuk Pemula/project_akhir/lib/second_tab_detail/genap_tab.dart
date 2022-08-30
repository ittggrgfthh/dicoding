import 'package:flutter/material.dart';
import 'package:project_akhir/model/matkul_list_model.dart';
import 'package:project_akhir/second_tab_detail/card_item_second_page.dart';

class GenapTab extends StatelessWidget {
  final DaftarMatkulRepository daftarMatkulRepository =
      DaftarMatkulRepository();
  GenapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: daftarMatkulRepository.readJson(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 900),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    itemCount: daftarMatkulRepository.listMK.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DaftarMatkulModel daftarMatkulModel =
                          daftarMatkulRepository.listMK.toList()[index];
                      if (daftarMatkulModel.semester % 2 == 0) {
                        return CardItem(
                          daftarMatkulModel: daftarMatkulModel,
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
