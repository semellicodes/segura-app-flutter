import 'package:flutter/material.dart';
import 'package:segura_app/screens/ajuda_imediata.dart';
import 'package:segura_app/screens/apoio.dart';
import 'package:segura_app/screens/leis.dart';
import 'package:segura_app/screens/map.dart';
import 'package:segura_app/screens/sobre_app.dart';

class AppData {
  static const List<String> menuOptions = [
    "AJUDA IMEDIATA",
    "MAPA DE SEGURANÇA",
    "ONDE BUSCAR APOIO",
    "LEIS E SINAIS",
    "SOBRE O APP",
  ];
  static const String appName = "SEGURA";
  static Map<String, Widget> routes = {
    "AJUDA IMEDIATA": const AjudaImediataScreen(),
    "MAPA DE SEGURANÇA": const MapScreen(),
    "ONDE BUSCAR APOIO": const ApoioScreen(),
    "LEIS E SINAIS": const LeisScreen(),
    "SOBRE O APP": const SobreApp(),
  };
  static const String centralmulher = "180";
  static const String policeNumber1 = "190";
  static const String policeNumber2 = "197";

  static const Map<String, String> tiposDeViolencia = {
    "Violência Física": "Agressão física, como empurrões, socos, chutes.",
    "Violência Psicológica":
        "Ameaças, humilhações, isolamento social. Fazer você duvidar da própria sanidade. (Gaslighting)",
    "Violência Sexual":
        "Assédio, estupro, abuso sexual ou impedir uso de anticoncepcional.",
    "Violência Patrimonial": "Controle financeiro, destruição de bens.",
    "Violência Moral": "Difamação, calúnia ou injúria.",
  };

  static const Map<String, String> locaisDeApoio = {
    "DEAM (Delegacia da Mulher)":
        "Atendimento especializado para mulheres vítimas de violência.",
    "Centro de Referência de Atendimento à Mulher (CRAM)":
        "Oferece apoio psicológico, social e jurídico.",
    "Casa Abrigo": "Refúgio temporário para mulheres em situação de risco.",
    "Defensoria Pública":
        "Assistência jurídica gratuita para vítimas de violência.",
    "Organizações Não Governamentais (ONGs)":
        "Diversas ONGs oferecem apoio e serviços especializados.",
  };

  static const Map<String, String> sinaisDeViolencia = {
    "Isolamento Social": "Afastamento de amigos e familiares.",
    "Mudanças de Comportamento": "Medo, ansiedade ou depressão.",
    "Lesões Físicas": "Ferimentos frequentes ou inexplicáveis.",
    "Controle Financeiro": "Dificuldade em acessar dinheiro ou recursos.",
    "Comportamento Controlador": "Parceiro controlando atividades e contatos.",
  };

  static const Map<String, String> sobreApp = {
    "Não usamos cookies de rastreamento:":
        "O Segura não coleta dados pessoais ou rastreia o comportamento dos usuários. Nosso foco é fornecer informações e recursos de forma segura e privada.",
    "Nenhum dado é salvo ou compartilhado:":
        "Não armazenamos informações pessoais dos usuários. Todas as interações com o app são anônimas e não vinculadas a identidades específicas.",
    "Funciona totalmente offline:":
        "O Segura foi projetado para funcionar sem conexão à internet, garantindo acesso a informações e recursos mesmo em situações de emergência onde a conectividade pode ser limitada.",
  };
}
