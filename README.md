# SEGURA

![Status](https://img.shields.io/badge/Status-Em%20Desenvolvimento-purple?style=flat-square)

Um aplicativo focado em oferecer um ambiente seguro e acessível, onde mulheres possam encontrar apoio, conhecer seus direitos e acessar serviços de emergência de forma rápida.

## Demonstração Visual

<div align="center">
  <img src="assets/tela_inicial.jpg" alt="Tela Inicial do Segura" width="30%">
  <img src="assets/tela_ajuda.jpg" alt="Tela de Ajuda Imediata" width="30%">
  <img src="assets/tela_mapa.jpg" alt="Mapa de Segurança Integrado" width="30%">
</div>

## Funcionalidades

- **Ajuda Imediata:** Acesso rápido ao discador do sistema para emergências (190, Polícia Militar; 197, Polícia Civil) e acolhimento (180, Central de Atendimento à Mulher).
- **Leis e Sinais de Alerta:** Informações acessíveis sobre a Lei Maria da Penha, Feminicídio e como identificar o ciclo da violência.
- **Mapa de Segurança:** Localização em tempo real via GPS para exibir delegacias e centros de apoio próximos à usuária.
- **Privacidade e Acessibilidade:** Não utiliza rastreamento de dados, não salva histórico de localização e possui funcionamento offline para os recursos de cartilhas e contatos de emergência.

## Tecnologias Utilizadas

- **[Flutter](https://flutter.dev/):** Framework para construção da interface nativa.
- **[Dart](https://dart.dev/):** Linguagem principal do projeto.
- **Pacotes:** - `url_launcher`: Integração nativa para abrir links externos e realizar ligações de emergência.
  - `flutter_map` e `latlong2`: Renderização de mapas interativos de código aberto.
  - `geolocator`: Comunicação nativa com o hardware do aparelho para acessar o GPS, respeitando as permissões de privacidade do sistema operacional.

## Como rodar o projeto

1. Clone este repositório:
   ```bash
   git clone [https://github.com/semellicodes/segura_app.git](https://github.com/semellicodes/segura_app.git)
   ```
