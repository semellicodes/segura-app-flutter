import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/constants/app_data.dart';
import 'package:segura_app/widgets/menu_principal_button.dart';
import 'package:segura_app/widgets/botao_sos.dart';
import 'package:segura_app/screens/camuflagem_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            SizedBox(height: 60),
            Text(
              AppData.appName,
              style: const TextStyle(
                color: AppColors.background,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...AppData.menuOptions.map(
              (option) => CustomMenuButton(
                title: option,
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
            ),
          ],
        ),
      ),
    );
  }
}
