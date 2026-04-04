import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheather_application/loging.dart';
import 'package:wheather_application/weather_page.dart';
import 'package:wheather_application/widget/profile_glassSquare.dart';
import 'package:wheather_application/services/AuthService.dart';
import 'package:wheather_application/services/WeatherService.dart';
import 'package:wheather_application/services/savingData.dart'; // Import your new backend file
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SavingData _savingData = SavingData(); // Initialize the new backend service

  Future<List<Map<String, dynamic>>> _loadSavedLocations() async {
    // Fetch directly from Supabase instead of local storage
    return await _savingData.getSavedLocations();
  }

  Future<void> _saveLocation(Map<String, dynamic> weatherData) async {
    // Save directly to Supabase
    await _savingData.saveLocationToBackend(weatherData);
    setState(() {}); // Refresh UI
  }

  void _showProfileOptions(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final userEmail = user?.email ?? 'Unknown User';
    final fullName = user?.userMetadata?['full_name'] ?? 'User Profile';

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(255, 2, 17, 29),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(fullName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(userEmail, style: const TextStyle(color: Colors.white70)),
              ),
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Logout', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                onTap: () async {
                  await Authservice().signOut();
                  if (!context.mounted) return;
                  Navigator.of(context).pop(); 
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
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
                               icon: const Icon(Icons.more_horiz, color: Colors.white),
                               onPressed: () => _showProfileOptions(context),
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                              title: Text('$cityName, $country', style: const TextStyle(color: Colors.black)),
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
                      const SizedBox(height: 20),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: _loadSavedLocations(), 
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 50.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 50.0),
                                child: Text("No locations saved yet", style: TextStyle(color: Colors.white)),
                              ),
                            );
                          }
                          
                          final weatherList = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: weatherList.length,
                            itemBuilder: (context, index) {
                              final item = weatherList[index];
                              return profileGlassSquare(
                                context: context,
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
                      const SizedBox(height: 20),
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