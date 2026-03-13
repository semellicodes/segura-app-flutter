import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:segura_app/services/localizacao.dart';
import 'package:segura_app/theme/app_colors.dart';
import 'package:segura_app/widgets/botoes_zoom.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();

  double _zoomAtual = 14.0;
  LatLng? _minhaPosicao;
  bool _carregandoLocalizacao = true;

  @override
  void initState() {
    super.initState();
    _buscarMinhaPosicao();
  }

  Future<void> _buscarMinhaPosicao() async {
    final posicao = await _locationService.pegarLocalizacaoAtual();

    setState(() {
      _carregandoLocalizacao = false;
      if (posicao != null) {
        _minhaPosicao = posicao;
      }
    });

    if (posicao != null) {
      _mapController.move(posicao, 15.0);
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
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.segura_app',
              ),
              if (_minhaPosicao != null)
                MarkerLayer(
                  markers: [
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
