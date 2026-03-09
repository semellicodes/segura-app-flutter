import 'package:flutter/material.dart';
import 'package:segura_app/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 241, 189, 189),
              Color.fromARGB(255, 255, 124, 101),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () {},
                ),
              ],
            ),
            const Spacer(),
            CustomMenuButton(title: "AJUDA IMEDIATA", onPressed: () {}),
            CustomMenuButton(title: "DENUNCIAR", onPressed: () {}),
            CustomMenuButton(title: "REDE DE APOIO", onPressed: () {}),
            CustomMenuButton(title: "LEIS E DIREITOS", onPressed: () {}),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
