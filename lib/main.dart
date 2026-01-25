import 'package:flutter/material.dart';
import 'package:wheather_application/home_page.dart';
import 'package:wheather_application/profilePage.dart';
import 'package:wheather_application/weather_page.dart';



void main() async {
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
