import 'package:flutter/material.dart';
import 'package:project_akhir/model/matkul_list_model.dart';

class CardItem extends StatefulWidget {
  final DaftarMatkulModel daftarMatkulModel;
  const CardItem({Key? key, required this.daftarMatkulModel}) : super(key: key);

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.daftarMatkulModel.block
                ? Colors.grey[300]
                : widget.daftarMatkulModel.selesai
                    ? Colors.red[100]
                    : Colors.lightBlue[100],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // ignore: unnecessary_string_interpolations
                      '${widget.daftarMatkulModel.namaMataKuliah} - ${widget.daftarMatkulModel.kodeMataKuliah}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        ' ${widget.daftarMatkulModel.sks.toString()} SKS - ${widget.daftarMatkulModel.jenis} - ${widget.daftarMatkulModel.kategori} - Semester ${widget.daftarMatkulModel.semester}'),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Column(
                        children: <Widget>[
                          Switch(
                              value: widget.daftarMatkulModel.block
                                  ? false
                                  : widget.daftarMatkulModel.selesai,
                              onChanged: widget.daftarMatkulModel.block
                                  ? null
                                  : (value) {
                                      setState(() => widget
                                          .daftarMatkulModel.selesai = value);
                                    })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
