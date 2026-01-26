import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheather_application/loging.dart';
import 'package:wheather_application/weather_page.dart';
import 'package:wheather_application/widget/profile_glassSquare.dart';
import 'package:wheather_application/services/AuthService.dart';
import 'package:wheather_application/services/WeatherService.dart';
//import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.white.withOpacity(1),
                            ),
                            offset: Offset(0, 50),
                            color: Color.fromARGB(
                              255,
                              2,
                              17,
                              29,
                            ).withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onSelected: (value) async {
                              if (value == 'logout') {
                                await Authservice().signOut();
                                if (context.mounted) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                    (route) => false,
                                  );
                                }
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'editList',
                                child: Text(
                                  'Edit List',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),

                              PopupMenuItem(
                                value: 'settings',
                                child: Text(
                                  'Settings',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'logout',
                                child: Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SearchAnchor(
                      builder:
                          (BuildContext context, SearchController controller) {
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
                      suggestionsBuilder:
                          (
                            BuildContext context,
                            SearchController controller,
                          ) async {
                            final String input = controller.text;
                            if (input.isEmpty) return [];
                            final weatherService = WeatherService();
                            //final response = await getCitySuggestions(input);
                            final List<dynamic> suggestions = await weatherService.getCitySuggestions(input);
                            return suggestions.map((city) {
                              final String cityName = city['name'];
                              final String country = city['country'];

                              return ListTile(
                                title: Text('$cityName, $country'),
                                onTap: () async {
                                  final weatherService = WeatherService();
                                  final weatherData = await weatherService.fetchLiveWeather(
                                    cityName,
                                  );
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WeatherPage(),
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
                        future: Future.value([]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("No locations saved yet"),
                            );
                          }
                          final weatherList = snapshot.data!;
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: weatherList.length,
                            itemBuilder: (context, index) {
                              final item = weatherList[index];
                              return profileGlassSquare(
                                context: context,
                                destinationPage: WeatherPage(),
                                country: item['country'],
                                time: "Saved Location",
                                detail: item['detail'] ?? '/N/A',
                                temp: item['temp'] ?? '--°',
                                location: item['high_low'] ?? 'H:--° L:--°',
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Learn more about weather data and map data',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
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
