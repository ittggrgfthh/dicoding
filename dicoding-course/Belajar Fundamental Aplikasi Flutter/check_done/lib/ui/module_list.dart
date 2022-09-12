import 'package:cart/provider/done_module_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModuleList extends StatefulWidget {
  final List<String> doneModuleList;
  const ModuleList({super.key, required this.doneModuleList});

  @override
  State<ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  final List<String> _moduleList = const [
    'Modul 1 - Pengenalan Dart',
    'Modul 2 - Program Dart Pertamamu',
    'Modul 3 - Dart Fundamental',
    'Modul 4 - Control Flow',
    'Modul 5 - Collections',
    'Modul 6 - Object Oriented Programming',
    'Modul 7 - Functional Styles',
    'Modul 8 - Dart Type System',
    'Modul 9 - Dart Futures',
    'Modul 10 - Effective Dart',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _moduleList.length,
      itemBuilder: (context, index) => Consumer<DoneModuleProvider>(
        builder: (context, DoneModuleProvider data, widget) => ModuleTile(
          modulName: _moduleList[index],
          isDone: data.doneModuleList.contains(_moduleList[index]),
          onClick: () => setState(
            () => data.doneModuleList.add(_moduleList[index]),
          ),
        ),
      ),
    );
  }
}

class ModuleTile extends StatelessWidget {
  final String modulName;
  final bool isDone;
  final Function() onClick;

  const ModuleTile({
    super.key,
    required this.modulName,
    required this.isDone,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(modulName),
      trailing: isDone
          ? const Icon(Icons.done)
          : ElevatedButton(
              onPressed: onClick,
              child: const Text('Done'),
            ),
    );
  }
}
