import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:segura_app/services/localizacao_service.dart';

class SOSService {
  final LocationService _locationService = LocationService();
  static const String _contactsKey = 'sos_contacts_list';

  Future<List<Map<String, String>>> obterContatos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? contatosJson = prefs.getStringList(_contactsKey);
    
    if (contatosJson == null) return [];
    
    try {
      return contatosJson.map((e) => Map<String, String>.from(jsonDecode(e))).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> adicionarContato(String nome, String numero) async {
    final prefs = await SharedPreferences.getInstance();
    final contatos = await obterContatos();
    
    // Evitar duplicatas exatas
    if (!contatos.any((c) => c['numero'] == numero)) {
      contatos.add({'nome': nome, 'numero': numero});
      final List<String> contatosJson = contatos.map((e) => jsonEncode(e)).toList();
      await prefs.setStringList(_contactsKey, contatosJson);
    }
  }

  Future<void> removerContato(String numero) async {
    final prefs = await SharedPreferences.getInstance();
    final contatos = await obterContatos();
    contatos.removeWhere((c) => c['numero'] == numero);
    
    final List<String> contatosJson = contatos.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(_contactsKey, contatosJson);
  }

  Future<bool> acionarSOS(String numero) async {
    if (numero.isEmpty) return false;

    // 1. Pega a localização
    final posicao = await _locationService.pegarLocalizacaoAtual();
    String mapsLink = '';
    
    if (posicao != null) {
      mapsLink = 'https://www.google.com/maps/search/?api=1&query=${posicao.latitude},${posicao.longitude}';
    } else {
      mapsLink = 'A localização não pôde ser obtida pelo GPS. Tente me contatar rápido.';
    }

    // 2. Formatar mensagem e Link do WhatsApp
    final mensagem = '🚨 URGENTE! Preciso de ajuda. Essa é minha localização atual: $mapsLink';
    
    // Remove qualquer caractere que não seja número ou +
    final numeroLimpo = numero.replaceAll(RegExp(r'[^\d+]'), '');
    
    final uri = Uri.parse('https://wa.me/$numeroLimpo?text=${Uri.encodeComponent(mensagem)}');
    
    // 3. Tenta abrir o zap nativamente
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return true;
    } catch (e) {
      return false;
    }
  }
}
