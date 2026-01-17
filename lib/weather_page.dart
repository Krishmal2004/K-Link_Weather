import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheather_application/main.dart';
import 'package:wheather_application/home_page.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
          Positioned.fill(
            child: Image.asset(
              'assets/weather_page.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WEATHER IN\nNEW YORK',
                        style: TextStyle(
                          color: Colors.white24.withOpacity(0.8),
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.settings_suggest_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white24.withOpacity(0.5),
                          thickness: 0.4,
                          endIndent: 5,
                        ),
                      ),
                      SizedBox(width: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'RAINY DAY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
