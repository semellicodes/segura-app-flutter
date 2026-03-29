import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/constants/educational_data.dart';
import 'package:segura_app/widgets/card_lei.dart';
import 'package:segura_app/widgets/card_topico_ajuda.dart';

class LeisScreen extends StatelessWidget {
  const LeisScreen({super.key});

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
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
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
                          "Leis que te protegem",
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
                        Leis(
                          titulo: "Lei Maria da Penha (11.340/2006):",
                          descricao: EducationalData
                              .leis["Lei Maria da Penha (11.340/2006):"]!,
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                          height: 15,
                        ),
                        Text(
                          "Ela não serve só para agressão física. A lei reconhece 5 tipos de violência doméstica:",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        ...EducationalData.tiposDeViolencia.entries.map((item) {
                          return Topico(
                            titulo: item.key,
                            descricao: item.value,
                          );
                        }),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                          height: 20,
                        ),
                        Leis(
                          titulo: "Lei do Feminicídio (13.104/2015):",
                          descricao: EducationalData
                              .leis["Lei do Feminicídio (13.104/2015):"]!,
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                          height: 15,
                        ),
                        Text(
                          "Sinais de Alerta",
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
                          "A violencia evolui. Identifique em que fase você está:",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 15),
                        ...EducationalData.sinaisAlerta.entries.map((item) {
                          return Topico(
                            titulo: item.key,
                            descricao: item.value,
                          );
                        }),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                          height: 20,
                        ),
                        Text(
                          "Promessas não substituem atitudes. A responsabilidade pela violência é do agressor.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
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
