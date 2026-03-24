import 'package:flutter/material.dart';

class ItemApoio extends StatelessWidget {
  final String titulo;
  final String descricao;

  const ItemApoio({super.key, required this.titulo, required this.descricao});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 5),

        Text(descricao, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Divider(height: 15, thickness: 1, color: Colors.grey[300]),
      ],
    );
  }
}
