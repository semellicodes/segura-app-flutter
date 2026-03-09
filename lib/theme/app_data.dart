import 'package:flutter/material.dart';
import 'package:segura_app/screens/ajuda_imediata.dart';

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
  };
  static const String centralmulher = "180";
  static const String policeNumber1 = "190";
  static const String policeNumber2 = "197";
}
