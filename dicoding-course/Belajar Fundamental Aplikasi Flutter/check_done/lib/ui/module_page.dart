import 'package:cart/ui/done_module_list.dart';
import 'package:cart/ui/module_list.dart';
import 'package:flutter/material.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({super.key});

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final List<String> doneModuleList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memulai Pemrograman dengan Dart"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoneModuleList(),
                  ),
                )),
          )
        ],
      ),
      body: ModuleList(doneModuleList: doneModuleList),
    );
  }
}
