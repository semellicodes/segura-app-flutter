import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.secondary, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                Text(
                  "SEGURA",
                  style: const TextStyle(
                    color: AppColors.background,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () {},
                ),
              ],
            ),
            const Spacer(),
            CustomMenuButton(title: "AJUDA IMEDIATA", onPressed: () {}),
            CustomMenuButton(title: "MAPA DE SEGURANÇA", onPressed: () {}),
            CustomMenuButton(title: "ONDE BUSCAR APOIO", onPressed: () {}),
            CustomMenuButton(title: "LEIS E SINAIS", onPressed: () {}),
            CustomMenuButton(title: "SOBRE O APP", onPressed: () {}),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
