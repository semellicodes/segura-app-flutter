import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';

class CustomMenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final FontWeight fontWeight;

  const CustomMenuButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontWeight: fontWeight),
          backgroundColor: color ?? AppColors.primary,
          foregroundColor: AppColors.background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size(300, 50),
        ),
        onPressed: onPressed,
        child: Text(title, textAlign: TextAlign.center),
      ),
    );
  }
}
