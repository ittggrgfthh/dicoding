import 'dart:convert';

import 'package:flutter/services.dart';

class DaftarMatkulModel {
  String kodeMataKuliah;
  String namaMataKuliah;
  int semester;
  String kategori;
  int sks;
  String jenis;
  bool selesai;
  bool block;

  DaftarMatkulModel({
    required this.kodeMataKuliah,
    required this.namaMataKuliah,
    required this.semester,
    required this.kategori,
    required this.sks,
    required this.jenis,
    required this.selesai,
    required this.block,
  });

  factory DaftarMatkulModel.fromJson(Map<String, dynamic> json) {
    return DaftarMatkulModel(
      kodeMataKuliah: json['kode_mata_kuliah'] as String,
      namaMataKuliah: json['nama_mata_kuliah'] as String,
      semester: json['semester'] as int,
      kategori: json['kategori'] as String,
      sks: json['sks'] as int,
      jenis: json['jenis'] as String,
      selesai: json['selesai'] as bool,
      block: json['block'] as bool,
    );
  }
}

class DaftarMatkulRepository {
  List<DaftarMatkulModel> listMK = [];

  DaftarMatkulRepository() {
    readJson();
  }

  Future<List<DaftarMatkulModel>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/daftar-matkul.json');
    final data = await json.decode(response);
    var lMK = await data['listMK']
        .map((data) => DaftarMatkulModel.fromJson(data))
        .toList();
    listMK = List<DaftarMatkulModel>.from(lMK);
    return listMK;
  }
}
