import 'package:supabase_flutter/supabase_flutter.dart';

class Authservice {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> login(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp(
    String email,
    String password,
    String fullName,
  ) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<List<Map<String, dynamic>>> getUserWeatherData() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      return [];
    }
    return await _supabase
        .from('weather_locations')
        .select()
        .eq('userId', userId);
  }
}
