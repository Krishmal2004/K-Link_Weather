import 'package:flutter/material.dart';
import 'package:wheather_application/home_page.dart';
import 'package:wheather_application/profilePage.dart';
import 'package:wheather_application/weather_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mmkzyvrpmevarjccaxfb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ta3p5dnJwbWV2YXJqY2NheGZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjkzNTI1MTMsImV4cCI6MjA4NDkyODUxM30.m6helLNiF_NkukASYhojxo7gM3yFpRVTPxyckJ7h_Tc',
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
