import 'package:flutter/material.dart';
import 'package:segura_app/screens/home_screen.dart';

void main() {
  runApp(const SeguraApp());
}

class SeguraApp extends StatelessWidget {
  const SeguraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
