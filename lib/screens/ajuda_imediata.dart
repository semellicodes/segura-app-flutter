import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AjudaImediataScreen extends StatelessWidget {
  const AjudaImediataScreen({super.key});

  Future<void> _fazerLigacao(String numero) async {
    final Uri url = Uri.parse('tel:$numero');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.background],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ajuda Imediata',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 44, 3, 140),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 30),
                          Text(
                            'Se você está em perigo imediato, ligue para o número de emergência local ou procure um lugar seguro imediatamente.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 30),
                          CustomMenuButton(
                            title: 'LIGUE 190 (POLÍCIA MILITAR)',
                            color: const Color.fromARGB(255, 167, 24, 17),
                            onPressed: () {
                              _fazerLigacao('190');
                            },
                          ),
                          CustomMenuButton(
                            title: 'LIGUE 197 (POLÍCIA CIVIL)',
                            color: const Color.fromARGB(255, 167, 24, 17),
                            onPressed: () {
                              _fazerLigacao('197');
                            },
                          ),
                          Divider(),
                          Text(
                            'Para orientação, denúncia anônima e acolhimento:',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 15),
                          CustomMenuButton(
                            title:
                                'LIGUE 180 (CENTRAL DE ATENDIMENTO À MULHER)',
                            color: const Color.fromARGB(255, 44, 3, 140),
                            onPressed: () {
                              _fazerLigacao('180');
                            },
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
      ),
    );
  }
}
