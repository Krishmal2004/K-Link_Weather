import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheather_application/main.dart';
import 'package:wheather_application/home_page.dart';
import 'package:wheather_application/widget/glassCircle.dart';
import 'package:wheather_application/widget/weatherDetails.dart';
import 'package:wheather_application/widget/bottomDetails.dart';

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
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 500),
                    child: child,
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WEATHER IN\nNEW YORK',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(
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
                            color: Colors.white.withOpacity(0.5),
                            thickness: 0.4,
                            endIndent: 5,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'RAINY DAY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Center(
                      child: SizedBox(
                        height: 180, 
                        width: 380,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none, 
                          children: [
                            Positioned(
                              left: -25,
                              bottom: 120, 
                              child: glassCircle(
                                size: 180,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.cloud, color: Colors.white, size: 80),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10,
                              top: -40, 
                              child: glassCircle(
                                size: 230,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '25 January 2025',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const Text(
                                      '10°',
                                      style: TextStyle(
                                        //color: Color(0xFF4A80F0),
                                        color: Colors.white54,
                                        fontSize: 85,
                                        fontWeight: FontWeight.w400,
                                        height: 1.0,
                                      ),
                                    ),
                                    const Text(
                                      '/Real Feel 8°',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40), 
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.5,
                      children: [
                        weatherDetails('Wind', Icons.air, '3.4', 'km/h'),
                        weatherDetails('Humidity', Icons.water_drop_outlined, '78', '%'),
                        weatherDetails('Pressure', Icons.speed, '1016', 'hpa'),
                        weatherDetails('UV index', Icons.wb_sunny_outlined, '2', ''),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.5),
                            thickness: 0.4,
                            endIndent: 0,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'Rainy Condition will continue all day.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.7,
                      children: [
                        bottomDetails('4 PM', Icons.cloud, '10°'),
                        bottomDetails('5 PM', Icons.storm, '10°'),
                        bottomDetails('5.46 PM', Icons.wb_twilight, 'SUNSET'),
                        bottomDetails('6 PM', Icons.nights_stay, '10°'),
                        bottomDetails('7 PM', Icons.nights_stay, '10°'),
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