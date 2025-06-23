import 'package:flutter/material.dart';
import 'package:work_assistent/presentation/pages/my_advertisement_page.dart';
import 'package:work_assistent/presentation/pages/new_advertisement_page.dart';
import 'package:work_assistent/presentation/pages/work_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
  home: const MyAdvertisementPage(),
);
  }
}
