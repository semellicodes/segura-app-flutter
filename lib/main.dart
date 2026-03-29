import 'package:flutter/material.dart';
import 'package:segura_app/screens/home_screen.dart';
import 'package:segura_app/screens/ajuda_imediata_screen.dart';
import 'package:segura_app/screens/locais_apoio_screen.dart';
import 'package:segura_app/screens/leis_sinais_screen.dart';
import 'package:segura_app/screens/mapa_seguranca_screen.dart';
import 'package:segura_app/screens/sobre_app_screen.dart';

void main() {
  runApp(const SeguraApp());
}

class SeguraApp extends StatelessWidget {
  const SeguraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/ajuda_imediata': (context) => const AjudaImediataScreen(),
        '/mapa_seguranca': (context) => const MapScreen(),
        '/locais_apoio': (context) => const ApoioScreen(),
        '/leis_sinais': (context) => const LeisScreen(),
        '/sobre_app': (context) => const SobreApp(),
      },
    );
  }
}
