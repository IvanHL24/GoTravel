import 'dart:convert';
import 'package:app_travels/models/travelDetail.dart';
import 'package:http/http.dart' as http;


Future<TravelD> fetchTravelDetails(String travelId) async {
  final url = Uri.parse('https://www.api.salonnefertaritravel.com/api/getTripBySlug/$travelId');

  final headers = {
    'x-api-key': '0d0e1d-cc8d04-ecd55e-a346e5-6e2ebc',
    'Content-Type': 'application/json',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return TravelD.fromJson(jsonData["viaje"]);
  } else {
    throw Exception('Error al cargar los detalles del viaje');
  }
}