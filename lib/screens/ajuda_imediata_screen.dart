import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/constants/app_data.dart';
import 'package:segura_app/widgets/menu_principal_button.dart';
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
      backgroundColor: AppColors.ajuda,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
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
                          'Ajuda Imediata',
                          style: TextStyle(
                            color: AppColors.ajuda,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Se você está em perigo imediato, ligue para o número de emergência local ou procure um lugar seguro imediatamente.',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Center(
                          child: CustomMenuButton(
                            title: 'LIGUE 190 (POLÍCIA MILITAR)',
                            color: AppColors.alertaVermelho,
                            onPressed: () {
                              _fazerLigacao(AppData.policeNumber1);
                            },
                          ),
                        ),
                        Center(
                          child: CustomMenuButton(
                            title: 'LIGUE 197 (POLÍCIA CIVIL)',
                            color: AppColors.alertaVermelho,
                            onPressed: () {
                              _fazerLigacao(AppData.policeNumber2);
                            },
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                        Text(
                          'Para orientação, denúncia anônima e acolhimento:',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Center(
                          child: CustomMenuButton(
                            title: 'LIGUE 180 (CENTRAL MULHER)',
                            color: AppColors.ajuda,
                            onPressed: () {
                              _fazerLigacao(AppData.centralmulher);
                            },
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
