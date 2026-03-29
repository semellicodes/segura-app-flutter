import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/constants/app_info_data.dart';
import 'package:segura_app/constants/app_images.dart';
import 'package:segura_app/constants/navigation_data.dart';
import 'package:segura_app/widgets/primary_action_card.dart';
import 'package:segura_app/widgets/secondary_action_tile.dart';
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
          icon: Icon(Icons.videogame_asset, color: Colors.white.withValues(alpha: 0.75)),
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 28),

              // Bloco de identidade visual (logo + nome)
              Column(
                children: [
                  // Sombra discreta ao redor da logo para destaca-la do gradiente
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.14),
                          blurRadius: 12,
                          spreadRadius: 0,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Opacity(
                      opacity: 0.92,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          AppImages.logo,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    AppInfoData.appName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3.0,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 52),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PrimaryActionCard(
                        title: NavigationData.menuItems.first.title,
                        icon: NavigationData.menuItems.first.icon,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, NavigationData.menuItems.first.routeName);
                        },
                      ),

                      const SizedBox(height: 40),

                      ...NavigationData.menuItems.skip(1).expand((item) => [
                            SecondaryActionTile(
                              title: item.title,
                              icon: item.icon,
                              onPressed: () {
                                Navigator.pushNamed(context, item.routeName);
                              },
                            ),
                            const SizedBox(height: 12),
                          ]),

                      const SizedBox(height: 88),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
