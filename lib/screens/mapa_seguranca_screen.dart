import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:segura_app/services/localizacao_service.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/widgets/mapa_zoom_buttons.dart';
import 'package:segura_app/services/delegacias_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();
  final DelegaciasService _delegaciasService = DelegaciasService();

  double _zoomAtual = 13.0; // Zoom retornado ao original para não ficar tão longe
  LatLng? _minhaPosicao;
  bool _carregandoLocalizacao = true;
  List<Map<String, dynamic>> _delegacias = [];

  @override
  void initState() {
    super.initState();
    _buscarMinhaPosicao();
  }

  Future<void> _buscarMinhaPosicao() async {
    final posicao = await _locationService.pegarLocalizacaoAtual();

    if (posicao != null) {
      if (mounted) setState(() => _minhaPosicao = posicao);
      
      _mapController.move(posicao, _zoomAtual);
      
      // Radar invisível de delegacias ao redor (Overpass)
      final postos = await _delegaciasService.buscarDelegaciasProximas(posicao);
      
      if (mounted) {
        setState(() {
          _delegacias = postos;
          _carregandoLocalizacao = false;
        });
      }
    } else {
      if (mounted) {
        setState(() => _carregandoLocalizacao = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⚠️ Ligue o botão de GPS (Localização) do seu celular para vermos o mapa e encontrar delegacias!'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _zoomIn() {
    setState(() {
      _zoomAtual++;
      _mapController.move(_mapController.camera.center, _zoomAtual);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomAtual--;
      _mapController.move(_mapController.camera.center, _zoomAtual);
    });
  }

  // Define a paleta de cores para cada especialidade policial
  Color _getCorDelegacia(String tipo) {
    switch (tipo) {
      case 'mulher': return Colors.purpleAccent;
      case 'civil': return Colors.black87;
      case 'militar': return Colors.blue[800]!;
      default: return Colors.blueGrey; // Guarda e trânsito
    }
  }

  Widget _buildLegendItem(Color cor, String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_police, color: cor, size: 16),
          const SizedBox(width: 5),
          Text(titulo, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(-15.793889, -47.882778),
              initialZoom: _zoomAtual,
            ),
            children: [
              TileLayer(
                // O OpenStreetMap padrão é 100% Livre e não trava por excesso de usuários em planos gratuítos!
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.segura_app',
              ),
              MarkerLayer(
                markers: [
                  // Marcador das Delegacias
                  ..._delegacias.map((d) => Marker(
                        point: d['posicao'] as LatLng,
                        width: 30, // Diminuímos para proporção humana 
                        height: 30,
                        child: GestureDetector(
                          onTap: () {
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text(d['nome'].toString())),
                             );
                          },
                          child: Icon(Icons.local_police, color: _getCorDelegacia(d['tipo']), size: 24), // Cor Dinâmica
                        ),
                      )),

                  // O Seu marcador (GPS)
                  if (_minhaPosicao != null)
                    Marker(
                      point: _minhaPosicao!,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.location_pin,
                        color: AppColors.alertaVermelho,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ],
          ),
          
          // Quadro Oculto da Legenda
          Positioned(
            bottom: 30,
            left: 10,
            child: Card(
              color: Colors.white.withAlpha(235), // Transparencia suave comAlpha
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tipos de Base', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 5),
                    _buildLegendItem(Colors.purpleAccent, 'Del. da Mulher (DEAM)'),
                    _buildLegendItem(Colors.black87, 'Polícia Civil'),
                    _buildLegendItem(Colors.blue[800]!, 'Polícia Militar'),
                    _buildLegendItem(Colors.blueGrey, 'Postos Comuns'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: CircleAvatar(
              backgroundColor: AppColors.ajuda,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          BotoesZoomWidget(onZoomIn: _zoomIn, onZoomOut: _zoomOut),
          if (_carregandoLocalizacao)
            Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.background),
              ),
            ),
        ],
      ),
    );
  }
}
