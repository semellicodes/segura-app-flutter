import 'package:flutter/material.dart';

class MenuItemModel {
  final String title;
  final IconData icon;
  final Widget destination;

  const MenuItemModel({
    required this.title,
    required this.icon,
    required this.destination,
  });
}
