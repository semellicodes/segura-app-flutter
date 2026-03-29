import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/constants/app_info_data.dart';
import 'package:segura_app/constants/navigation_data.dart';
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
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shield_moon_rounded, size: 48, color: AppColors.background),
                const SizedBox(width: 12),
                const Text(
                  AppInfoData.appName,
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
                  children: NavigationData.menuItems.map(
                    (item) => CustomMenuButton(
                      title: item.title,
                      icon: item.icon,
                      onPressed: () {
                        Navigator.pushNamed(context, item.routeName);
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
