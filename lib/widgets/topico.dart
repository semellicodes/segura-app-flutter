import 'package:flutter/material.dart';

class Topico extends StatelessWidget {
  final String titulo;
  final String descricao;

  const Topico({super.key, required this.titulo, required this.descricao});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          children: [
            TextSpan(
              text: '• $titulo ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            TextSpan(text: descricao),
          ],
        ),
      ),
    );
  }
}
