// lib/services/WeatherService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService { 
  final String apiKey = 'ef4b72b470a84c45b45193045261801';

  Future<Map<String, dynamic>> fetchLiveWeather(String city) async {
    final url = Uri.parse(
      'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('City not Found');
    }
  }
  Future<List<dynamic>> getCitySuggestions(String query) async {
    if (query.isEmpty) return [];
    final url = Uri.parse(
      'https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$query',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body); // Returns a List
    } else {
      return [];
    }
  }
}