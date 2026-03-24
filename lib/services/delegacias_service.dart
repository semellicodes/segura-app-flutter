import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class DelegaciasService {
  /// Busca 'amenity=police' em um raio X metros da posição dada pelo GPS
  /// Usaremos um raio equilibrado de 15.000m (15km).
  Future<List<Map<String, dynamic>>> buscarDelegaciasProximas(LatLng posicao) async {
    final lat = posicao.latitude;
    final lon = posicao.longitude;
    const raio = 15000; 
    
    // Query na linguagem de script OQL (Overpass QL)
    final query = '''
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
      // Modificamos a forma de enviar o Body -> Servidores bloqueam dados crus em alguns casos.
      // E é crucial mandar o nome do nosso app pelo User-Agent!
      final response = await http.post(
        uri, 
        body: {'data': query},
        headers: {
          'User-Agent': 'SeguraApp/1.0 (Safety App for Women Auth)',
        }
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final elements = data['elements'] as List;
        
        return elements.map((e) {
          // Em relations e ways, o Overpass calcula o 'center' porque passamos `out center;`
          final double pLat = e['lat'] ?? e['center']['lat'];
          final double pLon = e['lon'] ?? e['center']['lon'];
          final String nome = (e['tags'] != null && e['tags']['name'] != null)
              ? e['tags']['name'] 
              : 'Posto Policial / Delegacia';

          // Análise de Substrings para Categorização da Corporação
          String tipo = 'geral';
          final txt = nome.toLowerCase();
          
          if (txt.contains('mulher') || txt.contains('deam')) {
            tipo = 'mulher';
          } else if (txt.contains('civil') || txt.contains('seccional')) {
            tipo = 'civil';
          } else if (txt.contains('militar') || txt.contains('bpm') || txt.contains('batalhão') || txt.contains('pm')) {
            tipo = 'militar';
          }

          return {
            'nome': nome,
            'tipo': tipo,
            'posicao': LatLng(pLat, pLon),
          };
        }).toList();
      }
    } catch (e) {
      // Retorna lista crua se faltar internet
    }
    
    return [];
  }
}
