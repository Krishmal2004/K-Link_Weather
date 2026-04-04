import 'package:supabase_flutter/supabase_flutter.dart';

class SavingData {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> saveLocationToBackend(Map<String, dynamic> weatherData) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    final locationName = weatherData['location']['name'];
    final country = weatherData['location']['country'];
    final temp = '${weatherData['current']['temp_c'].toInt()}°';
    final condition = weatherData['current']['condition']['text'];

    await _supabase.from('saved_locations').upsert({
      'user_id': user.id,
      'location_name': locationName,
      'country': country,
      'temp': temp,
      'condition': condition,
      'weather_data': weatherData,
    }, onConflict: 'user_id, location_name');
  }

  Future<List<Map<String, dynamic>>> getSavedLocations() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final response = await _supabase
        .from('saved_locations')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false); 
    return response.map<Map<String, dynamic>>((item) => {
      'country': item['country'],
      'detail': item['condition'],
      'temp': item['temp'],
      'high_low': item['location_name'],
      'weatherData': item['weather_data'], 
    }).toList();
  }
}