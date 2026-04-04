import 'package:flutter/material.dart';
import 'package:wheather_application/home_page.dart';
import 'package:wheather_application/profilePage.dart';
import 'package:wheather_application/weather_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mihqtmgzooeppkrymnak.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1paHF0bWd6b29lcHBrcnltbmFrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUzMDc0MTksImV4cCI6MjA5MDg4MzQxOX0.kFJo3QFbLhjngaGhRjyf5wDuAl5MuiJzSgxv02ov-SI',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
