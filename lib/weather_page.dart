import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheather_application/widget/glassCircle.dart'; 
import 'package:wheather_application/widget/weatherDetails.dart'; 
import 'package:wheather_application/widget/bottomDetails.dart'; 

class WeatherPage extends StatelessWidget {
  final Map<String, dynamic>? weatherData;
  const WeatherPage({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    // Extract dynamic data from the JSON map inside build
    final location = weatherData?['location']?['name'] ?? 'NEW YORK';
    final temp = weatherData?['current']?['temp_c']?.toInt().toString() ?? '10';
    final condition = weatherData?['current']?['condition']?['text'] ?? 'RAINY DAY';
    final wind = weatherData?['current']?['wind_kph']?.toString() ?? '3.4';
    final humidity = weatherData?['current']?['humidity']?.toString() ?? '78';
    final pressure = weatherData?['current']?['pressure_mb']?.toString() ?? '1016';
    final uv = weatherData?['current']?['uv']?.toString() ?? '2';

    // Extract hourly list from forecast data
    final List hourlyList = weatherData?['forecast']?['forecastday']?[0]?['hour'] ?? [];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black, // Fixes the white bar at bottom
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
              bottom: false, // Allows image to flow behind navigation bar
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
                          Text(
                            'WEATHER IN\n${location.toUpperCase()}',
                            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
                          ),
                          const Icon(Icons.settings_suggest_rounded, color: Colors.white, size: 40),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white.withOpacity(0.5), thickness: 0.4)),
                          const SizedBox(width: 10),
                          Text(condition.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 18)),
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
                                left: -10, bottom: 100,
                                child: glassCircle(size: 180, child: const Icon(Icons.nights_stay, color: Colors.white, size: 80)),
                              ),
                              Positioned(
                                right: -18, top: -10,
                                child: glassCircle(
                                  size: 220,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('26 January 2026', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                      Text('$temp°', style: const TextStyle(color: Colors.white54, fontSize: 80, fontWeight: FontWeight.w400, height: 1.0)),
                                      const Text('/ Real Feel 8°', style: TextStyle(color: Colors.white, fontSize: 16)),
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
                          weatherDetails('Wind', Icons.air, wind, 'km/h'),
                          weatherDetails('Humidity', Icons.water_drop_outlined, humidity, '%'),
                          weatherDetails('Pressure', Icons.speed, pressure, 'hpa'),
                          weatherDetails('UV Index', Icons.wb_sunny_outlined, uv, ''),
                        ],
                      ),
                      Divider(color: Colors.white.withOpacity(0.5), thickness: 0.4),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Hourly Forecast', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      
                      // DYNAMIC HOURLY FORECAST SECTION
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: hourlyList.map((hour) {
                            final String time = hour['time'].toString().split(' ')[1]; // Extracts "HH:mm"
                            final String hTemp = hour['temp_c'].toInt().toString();
                            final String hCondition = hour['condition']['text'].toLowerCase();

                            IconData hIcon = Icons.cloud;
                            if (hCondition.contains('sun')) hIcon = Icons.wb_sunny;
                            if (hCondition.contains('rain')) hIcon = Icons.umbrella;
                            if (hCondition.contains('night')) hIcon = Icons.nights_stay;

                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: bottomDetails(time, hIcon, '$hTemp°'),
                            );
                          }).toList(),
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