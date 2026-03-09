import 'package:flutter/material.dart';
import 'package:segura_app/theme/app_colors.dart';

class ApoioScreen extends StatelessWidget {
  const ApoioScreen({super.key});

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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 44, 3, 140),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
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
                              "Rede de Apoio",
                              style: TextStyle(
                                color: AppColors.ajuda,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              color: AppColors.ajuda,
                              thickness: 1,
                              height: 20,
                            ),

                            Text(
                              "DEAM (Delegacia da Mulher):",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            Text(
                              "É o local especializado para registrar boletim de ocorrência e pedir medidas protetivas. Nem todas as cidades possuem DEAM. Em qualquer local, a denúncia pode ser feita em uma delegacia comum ou pelo 190.",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(
                              color: AppColors.ajuda,
                              thickness: 1,
                              height: 20,
                            ),
                            Text(
                              "Defensoria Pública:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Oferece advogados gratuitos para garantir seus direitos na justiça.",
                              style: TextStyle(fontSize: 20),
                            ),

                            Divider(
                              color: AppColors.ajuda,
                              thickness: 1,
                              height: 20,
                            ),

                            Text(
                              "Casa da Mulher Brasileira:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Em algumas capitais, reúne delegacia, juizado e apoio psicológico no mesmo lugar.",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Você não está sozinha. Existem serviços públicos para te proteger e orientar.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
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
