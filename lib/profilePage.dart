import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheather_application/loging.dart';
import 'package:wheather_application/weather_page.dart';
import 'package:wheather_application/widget/profile_glassSquare.dart';
import 'package:wheather_application/services/AuthService.dart';
import 'package:wheather_application/services/WeatherService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  Future<List<Map<String, dynamic>>> _loadSavedLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedStrings = prefs.getStringList('saved_locations') ?? [];
    
    return savedStrings.map((str) => Map<String, dynamic>.from(jsonDecode(str))).toList().reversed.toList();
  }

  Future<void> _saveLocation(Map<String, dynamic> weatherData) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedStrings = prefs.getStringList('saved_locations') ?? [];
    
    final locationName = weatherData['location']['name'];
    final country = weatherData['location']['country'];
    final temp = weatherData['current']['temp_c'].toInt().toString();
    final condition = weatherData['current']['condition']['text'];

    final Map<String, dynamic> newEntry = {
      'country': country,
      'detail': condition,
      'temp': '$temp°',
      'high_low': locationName, 
      'weatherData': weatherData, 
    };

    savedStrings.removeWhere((item) => jsonDecode(item)['high_low'] == locationName);
    savedStrings.add(jsonEncode(newEntry));
    
    await prefs.setStringList('saved_locations', savedStrings);
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 17, 29),
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weather',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: IconButton(
                             icon: Icon(Icons.more_horiz, color: Colors.white),
                             onPressed: () {},
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          hintText: 'Search for a city',
                          hintStyle: WidgetStateProperty.all(
                            const TextStyle(color: Colors.white70),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            Colors.white.withOpacity(0.1),
                          ),
                          onTap: () => controller.openView(),
                          onChanged: (_) => controller.openView(),
                          leading: const Icon(
                            Icons.search,
                            color: Colors.white70,
                          ),
                        );
                      },
                      suggestionsBuilder: (BuildContext context, SearchController controller) async {
                        final String input = controller.text;
                        if (input.isEmpty) return [];
                        final weatherService = WeatherService();
                        final List<dynamic> suggestions = await weatherService.getCitySuggestions(input);
                        
                        return suggestions.map((city) {
                          final String cityName = city['name'];
                          final String country = city['country'];

                          return ListTile(
                            title: Text('$cityName, $country', style: TextStyle(color: Colors.black)),
                            onTap: () async {
                              final weatherData = await weatherService.fetchLiveWeather(cityName);
                              
                              await _saveLocation(weatherData);

                              if (context.mounted) {
                                controller.closeView(cityName);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WeatherPage(weatherData: weatherData),
                                  ),
                                );
                              }
                            },
                          );
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: _loadSavedLocations(), 
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("No locations saved yet", style: TextStyle(color: Colors.white)),
                            );
                          }
                          
                          final weatherList = snapshot.data!;
                          return ListView.builder(
                            itemCount: weatherList.length,
                            itemBuilder: (context, index) {
                              final item = weatherList[index];
                              return profileGlassSquare(
                                context: context,
                                // Pass the full saved weather data to the WeatherPage
                                destinationPage: WeatherPage(weatherData: item['weatherData']),
                                country: item['country'] ?? 'Unknown',
                                time: "Saved Location",
                                detail: item['detail'] ?? 'N/A',
                                temp: item['temp'] ?? '--°',
                                location: item['high_low'] ?? 'Unknown',
                              );
                            },
                          );
                        },
                      ),
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