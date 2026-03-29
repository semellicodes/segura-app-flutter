import 'package:flutter/material.dart';
import 'package:segura_app/models/menu_item_model.dart';

class NavigationData {
  static const List<MenuItemModel> menuItems = [
    MenuItemModel(
      title: "AJUDA IMEDIATA",
      icon: Icons.warning_rounded,
      routeName: '/ajuda_imediata',
    ),
    MenuItemModel(
      title: "MAPA DE SEGURANÇA",
      icon: Icons.map_rounded,
      routeName: '/mapa_seguranca',
    ),
    MenuItemModel(
      title: "ONDE BUSCAR APOIO",
      icon: Icons.support_agent_rounded,
      routeName: '/locais_apoio',
    ),
    MenuItemModel(
      title: "LEIS E SINAIS",
      icon: Icons.gavel_rounded,
      routeName: '/leis_sinais',
    ),
    MenuItemModel(
      title: "SOBRE O APP",
      icon: Icons.info_outline_rounded,
      routeName: '/sobre_app',
    ),
  ];
}
