import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/constants/app_info_data.dart';
import 'package:segura_app/widgets/card_sobre_app.dart';
import 'package:url_launcher/url_launcher.dart';

class SobreApp extends StatelessWidget {
  const SobreApp({super.key});
  Future<void> _abrirLink() async {
    final Uri url = Uri.parse('https://github.com/semellicodes');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ajuda,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios, size: 18),
                  label: const Text(
                    'Voltar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sobre o App",
                          style: TextStyle(
                            color: AppColors.ajuda,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                          height: 20,
                        ),
                        Text(
                          "Nosso objetivo é oferecer um ambiente seguro e acessível, onde as vítimas possam encontrar apoio, conhecer seus direitos e acessar serviços de ajuda de forma rápida e eficiente.",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                          height: 20,
                        ),
                        ...AppInfoData.sobreApp.entries.map((entry) {
                          return ItemSobreapp(
                            titulo: entry.key,
                            descricao: entry.value,
                          );
                        }),

                        SizedBox(height: 15),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              _abrirLink();
                            },
                            child: Text(
                              "@semellicodes",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
