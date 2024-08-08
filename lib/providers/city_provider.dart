import 'package:flutter/material.dart';
import 'package:interview_flutter/models/city.dart';
import 'package:interview_flutter/services/api_service.dart';

class CityProvider with ChangeNotifier{
  final List<City> _cities = [];
  List<City> _suggestions = [];

  List<City> get cities => _cities;
  List<City> get suggestions => _suggestions;

  Future<void> fetchSuggestions(String input) async {
    try {
      _suggestions = (await ApiService.getCitySuggestions(input))!;
      notifyListeners();
    } catch (error) {
      throw Exception(error);
    }
  }
  Future<void> fetchWeatherConditions(City city) async {
    try {
      final weatherData = await ApiService.getWeatherConditions(city.key);
      city.weatherText = weatherData?['WeatherText'];
      city.weatherIcon = weatherData?['WeatherIcon'];
      city.localObservationDateTime = weatherData!['LocalObservationDateTime'];
      notifyListeners();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> addCity(City city, String description) async {
    try {
      city.description = description;
      _cities.add(city);
      notifyListeners();
      await fetchWeatherConditions(city);
    } catch (error) {
      throw Exception(error);
    }
  }

  void clearSuggestions() {
    _suggestions = [];
    notifyListeners();
  }
}