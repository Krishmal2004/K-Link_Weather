import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wheather_application/services/WeatherService.dart';
import 'package:wheather_application/widget/glassCircle.dart'; 
import 'package:wheather_application/widget/weatherDetails.dart'; 
import 'package:wheather_application/widget/bottomDetails.dart'; 

class WeatherPage extends StatefulWidget {
  final Map<String, dynamic>? weatherData;
  final String cityName; 

  const WeatherPage({
    super.key, 
    this.weatherData, 
    required this.cityName,
  });

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Map<String, dynamic>? weatherData;
  Timer? _timer;
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    weatherData = widget.weatherData;
    
    _timer = Timer.periodic(const Duration(minutes: 15), (timer) {
      _refreshWeatherData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }

  Future<void> _refreshWeatherData() async {
    try {
      final newData = await _weatherService.fetchLiveWeather(widget.cityName);
      if (mounted) {
        setState(() {
          weatherData = newData;
        });
      }
    } catch (e) {
      debugPrint("Failed to automatically update weather: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final location = weatherData?['location']?['name'] ?? widget.cityName;
    final temp = weatherData?['current']?['temp_c']?.toInt().toString() ?? '10';
    
    final feelsLike = weatherData?['current']?['feelslike_c']?.toInt().toString() ?? '8';
    
    final condition = weatherData?['current']?['condition']?['text'] ?? 'RAINY DAY';
    final wind = weatherData?['current']?['wind_kph']?.toString() ?? '3.4';
    final humidity = weatherData?['current']?['humidity']?.toString() ?? '78';
    final pressure = weatherData?['current']?['pressure_mb']?.toString() ?? '1016';
    final uv = weatherData?['current']?['uv']?.toString() ?? '2';

    final String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    final isDay = weatherData?['current']?['is_day'] ?? 1;
    final conditionLower = condition.toLowerCase();
    IconData mainIcon = Icons.wb_sunny;
    
    if (conditionLower.contains('rain')) {
      mainIcon = Icons.umbrella;
    } else if (conditionLower.contains('cloud') || conditionLower.contains('overcast')) {
      mainIcon = Icons.cloud;
    } else if (isDay == 0 || conditionLower.contains('night') || conditionLower.contains('clear')) {
      mainIcon = Icons.nights_stay;
    }

    final List hourlyList = weatherData?['forecast']?['forecastday']?[0]?['hour'] ?? [];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black, 
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
              bottom: false, 
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ADDED: Back Button
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 4.0, right: 12.0),
                              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'WEATHER IN\n${location.toUpperCase()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: _refreshWeatherData,
                            child: const Icon(Icons.refresh, color: Colors.white, size: 30),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white.withOpacity(0.5), thickness: 0.4)),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              condition.toUpperCase(),
                              style: const TextStyle(color: Colors.white, fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
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
                                left: -10, bottom: 100,
                                child: glassCircle(size: 180, child: Icon(mainIcon, color: Colors.white, size: 80)),
                              ),
                              Positioned(
                                right: -18, top: -10,
                                child: glassCircle(
                                  size: 220,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(currentDate, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                                      Text('$temp°', style: const TextStyle(color: Colors.white54, fontSize: 80, fontWeight: FontWeight.w400, height: 1.0)),
                                      Text('/ Real Feel $feelsLike°', style: const TextStyle(color: Colors.white, fontSize: 16)),
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
                            if (hCondition.contains('night') || hCondition.contains('clear')) hIcon = Icons.nights_stay;

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