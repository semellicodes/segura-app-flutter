import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/theme/app_data.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
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
            const SizedBox(height: 20),
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
