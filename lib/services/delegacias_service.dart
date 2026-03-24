import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class DelegaciasService {
  Future<List<Map<String, dynamic>>> buscarDelegaciasProximas(
    LatLng posicao,
  ) async {
    final lat = posicao.latitude;
    final lon = posicao.longitude;
    const raio = 15000;

    final query =
        '''
      [out:json][timeout:15];
      (
        node["amenity"="police"](around:$raio,$lat,$lon);
        way["amenity"="police"](around:$raio,$lat,$lon);
        relation["amenity"="police"](around:$raio,$lat,$lon);
      );
      out center;
    ''';

    final uri = Uri.parse('https://overpass-api.de/api/interpreter');

    try {
      final response = await http.post(
        uri,
        body: {'data': query},
        headers: {'User-Agent': 'SeguraApp/1.0 (Safety App for Women Auth)'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final elements = data['elements'] as List;

        return elements.map((e) {
          final double pLat = e['lat'] ?? e['center']['lat'];
          final double pLon = e['lon'] ?? e['center']['lon'];
          final String nome = (e['tags'] != null && e['tags']['name'] != null)
              ? e['tags']['name']
              : 'Posto Policial / Delegacia';

          String tipo = 'geral';
          final txt = nome.toLowerCase();

          if (txt.contains('mulher') || txt.contains('deam')) {
            tipo = 'mulher';
          } else if (txt.contains('civil') || txt.contains('seccional')) {
            tipo = 'civil';
          } else if (txt.contains('militar') ||
              txt.contains('bpm') ||
              txt.contains('batalhão') ||
              txt.contains('pm')) {
            tipo = 'militar';
          }

          return {'nome': nome, 'tipo': tipo, 'posicao': LatLng(pLat, pLon)};
        }).toList();
      }
    } catch (e) {
      return [];
    }
    
    return [];
  }
}
