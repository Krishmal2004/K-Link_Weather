import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchLiveWeather(String city) async {
  const apiKey = 'ef4b72b470a84c45b45193045261801';
  final url = Uri.parse(
    'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
  );
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('City not Found');
  }
}
