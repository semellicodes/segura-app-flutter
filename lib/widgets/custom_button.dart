import 'package:flutter/material.dart';

class CustomMenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomMenuButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          foregroundColor: const Color.fromARGB(255, 251, 251, 251),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size(300, 50),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
