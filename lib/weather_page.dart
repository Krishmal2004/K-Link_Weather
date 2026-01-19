import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'WEATHER IN\nNEW YORK',
                            style: TextStyle(
                              color: Colors.white,
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
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white.withOpacity(0.5),
                              thickness: 0.4,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'RAINY DAY',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 80),
                      Center(
                        child: SizedBox(
                          height: 200,
                          width: 380,
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -10,
                                bottom: 100,
                                child: glassCircle(
                                  size: 180,
                                  child: const Icon(
                                    Icons.cloud,
                                    color: Colors.white,
                                    size: 80,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -18,
                                top: -10,
                                child: glassCircle(
                                  size: 220,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        '25 January 2025',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Text(
                                        '10°',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 80,
                                          fontWeight: FontWeight.w400,
                                          height: 1.0,
                                        ),
                                      ),
                                      const Text(
                                        '/ Real Feel 8°',
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
                          weatherDetails(
                            'Humidity',
                            Icons.water_drop_outlined,
                            '78',
                            '%',
                          ),
                          weatherDetails(
                            'Pressure',
                            Icons.speed,
                            '1016',
                            'hpa',
                          ),
                          weatherDetails(
                            'UV Index',
                            Icons.wb_sunny_outlined,
                            '2',
                            '',
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white.withOpacity(0.5),
                        thickness: 0.4,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Rainy Condition will continue all day.',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            bottomDetails('4 PM', Icons.cloud, '10°'),
                            SizedBox(width: 20,),
                            bottomDetails('5 PM', Icons.cloud, '9°'),
                            SizedBox(width: 20,),
                            bottomDetails(
                              '5:46 PM',
                              Icons.wb_twilight,
                              'SUNSET',
                            ),
                            SizedBox(width: 20,),
                            bottomDetails('6 PM', Icons.nights_stay, '9°'),
                            SizedBox(width: 20,),
                            bottomDetails('7 PM', Icons.nights_stay, '8°'),
                            SizedBox(width: 20,),
                            bottomDetails('8 PM', Icons.nights_stay, '8°'),
                            bottomDetails('9 PM', Icons.nights_stay, '7°'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
