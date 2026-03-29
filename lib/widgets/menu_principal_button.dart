import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';

class CustomMenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final FontWeight fontWeight;
  final IconData? icon;

  const CustomMenuButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.fontWeight = FontWeight.bold,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      textStyle: TextStyle(fontWeight: fontWeight, fontSize: 16),
      elevation: 4,
      backgroundColor: backgroundColor ?? Colors.white,
      foregroundColor: foregroundColor ?? AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      minimumSize: const Size(double.infinity, 60),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: icon != null
          ? ElevatedButton.icon(
              style: style,
              onPressed: onPressed,
              icon: Icon(icon, size: 28),
              label: Text(title, textAlign: TextAlign.center),
            )
          : ElevatedButton(
              style: style,
              onPressed: onPressed,
              child: Text(title, textAlign: TextAlign.center),
            ),
    );
  }
}
