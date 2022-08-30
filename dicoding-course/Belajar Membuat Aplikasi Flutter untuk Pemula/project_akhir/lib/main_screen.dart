import 'package:flutter/material.dart';
import 'package:project_akhir/first_page.dart';
import 'package:project_akhir/second_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;
  final screen = [
    const FirstPage(),
    const SecondPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'KRS SUNIDU v26.08.2022',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(child: screen[currentPage]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (int index) => setState(() => currentPage = index),
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        iconSize: 35,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Daftar Mata Kuliah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pattern_rounded),
            label: 'Pola Pengambilan KRS',
          ),
        ],
      ),
    );
  }
}
