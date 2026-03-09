import 'package:flutter/material.dart';
import 'package:segura_app/screens/ajuda_imediata.dart';
import 'package:segura_app/screens/apoio.dart';
import 'package:segura_app/screens/map.dart';

class AppData {
  static const List<String> menuOptions = [
    "AJUDA IMEDIATA",
    "MAPA DE SEGURANÇA",
    "ONDE BUSCAR APOIO",
    "LEIS E SINAIS",
    "SOBRE O APP",
  ];
  static const String appName = "SEGURA";
  static Map<String, Widget> routes = {
    "AJUDA IMEDIATA": const AjudaImediataScreen(),
    "MAPA DE SEGURANÇA": const MapScreen(),
    "ONDE BUSCAR APOIO": const ApoioScreen(),
    "LEIS E SINAIS": const Scaffold(body: Center(child: Text("Em breve"))),
    "SOBRE O APP": const Scaffold(body: Center(child: Text("Em breve"))),
  };
  static const String centralmulher = "180";
  static const String policeNumber1 = "190";
  static const String policeNumber2 = "197";
}
