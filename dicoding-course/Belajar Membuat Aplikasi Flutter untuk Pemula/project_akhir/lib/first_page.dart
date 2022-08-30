import 'package:flutter/material.dart';
import 'package:project_akhir/card_item.dart';
import 'package:project_akhir/model/matkul_list_model.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 600) {
              return ListMatkul();
            } else {
              return GridMatkul();
            }
          },
        ),
      ),
    );
  }
}

class ListMatkul extends StatelessWidget {
  final DaftarMatkulRepository daftarMatkulRepository =
      DaftarMatkulRepository();
  ListMatkul({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: daftarMatkulRepository.readJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: <Widget>[
              Expanded(
                //kolom 1
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.blue.shade900, width: 5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'SKS Selesai',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "84",
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'SKS Lulus',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                '144',
                                style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    itemCount: daftarMatkulRepository.listMK.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DaftarMatkulModel daftarMatkulModel =
                          daftarMatkulRepository.listMK.toList()[index];
                      return CardItem(
                        daftarMatkulModel: daftarMatkulModel,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class GridMatkul extends StatelessWidget {
  final DaftarMatkulRepository daftarMatkulRepository =
      DaftarMatkulRepository();
  GridMatkul({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: daftarMatkulRepository.readJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: <Widget>[
              Expanded(
                //kolom 1
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  constraints: const BoxConstraints(maxWidth: 900),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.blue.shade900, width: 5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'SKS Selesai',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "84",
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'SKS Lulus',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                '144',
                                style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      ListView.builder(
                        itemCount: daftarMatkulRepository.listMK.length,
                        itemBuilder: (BuildContext context, int index) {
                          final DaftarMatkulModel daftarMatkulModel =
                              daftarMatkulRepository.listMK
                                  .where((matkul) => matkul.semester % 2 == 1)
                                  .toList()[index];

                          return CardItem(daftarMatkulModel: daftarMatkulModel);
                        },
                      ),
                      ListView.builder(
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
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
