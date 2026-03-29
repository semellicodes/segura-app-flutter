import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/constants/app_data.dart';
import 'package:segura_app/widgets/menu_principal_button.dart';
import 'package:segura_app/widgets/botao_sos.dart';
import 'package:segura_app/screens/camuflagem_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  IconData _getIconForOption(String option) {
    switch (option) {
      case "AJUDA IMEDIATA":
        return Icons.warning_rounded;
      case "MAPA DE SEGURANÇA":
        return Icons.map_rounded;
      case "ONDE BUSCAR APOIO":
        return Icons.support_agent_rounded;
      case "LEIS E SINAIS":
        return Icons.gavel_rounded;
      case "SOBRE O APP":
        return Icons.info_outline_rounded;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const BotaoSosWidget(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.videogame_asset, color: AppColors.background),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CamuflagemScreen()),
            );
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.secondary, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shield_moon_rounded, size: 48, color: AppColors.background),
                const SizedBox(width: 12),
                const Text(
                  AppData.appName,
                  style: TextStyle(
                    color: AppColors.background,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: AppData.menuOptions.map(
                    (option) => CustomMenuButton(
                      title: option,
                      icon: _getIconForOption(option),
                      onPressed: () {
                        final destination = AppData.routes[option];

                        if (destination != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => destination),
                          );
                        }
                      },
                    ),
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
