import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  Future<LatLng?> pegarLocalizacaoAtual() async {
    LocationPermission permission;

    // 1. Verifica e PEDE as permissões primeiro, mesmo se o botão GPS do celular estiver solto.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    // 2. Tenta pegar a posição de fato. Se o botão de GPS físico estiver desligado,
    // o Flutter lançará um erro, então a gente captura e retorna nulo para avisar fofamente na UI.
    try {
      Position posicao = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 5),
        )
      );
      return LatLng(posicao.latitude, posicao.longitude);
    } catch (e) {
      return null; // GPS off na bandeja ou sinal ruim
    }
  }
}
