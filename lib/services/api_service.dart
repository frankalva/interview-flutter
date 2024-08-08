import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:interview_flutter/models/city.dart';

class ApiService {
  static const String apiKey = "JlT0KFoxovKL3040Zpb3FLnIXpaoHu8a";
  static const String baseUrl = "http://dataservice.accuweather.com";

  //Obtener las sugerencias de las ciudades
  static Future<List<City>?> getCitySuggestions(String query) async{
    final url = '$baseUrl/locations/v1/cities/autocomplete?apikey=$apiKey&q=$query';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => City.fromJson(json)).toList();
      } else {
        throw Exception('Error de solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error de red: $error'); 
    }
  }
  //Obtener las condiciones metereologicas
  static Future<Map<String, dynamic>?> getWeatherConditions(String key) async {
    final url = '$baseUrl/currentconditions/v1/$key?apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data[0];
      } else {
        throw Exception('Error de solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error de red: $error'); 
    }
  }
}