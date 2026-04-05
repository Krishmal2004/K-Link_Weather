import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheather_application/loging.dart';
import 'package:wheather_application/weather_page.dart';
import 'package:wheather_application/widget/profile_glassSquare.dart';
import 'package:wheather_application/services/AuthService.dart';
import 'package:wheather_application/services/WeatherService.dart';
import 'package:wheather_application/services/savingData.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SavingData _savingData = SavingData(); 

  Future<List<Map<String, dynamic>>> _loadSavedLocations() async {
    return await _savingData.getSavedLocations();
  }

  // ADDED BACK: The method to save the location and refresh the UI
  Future<void> _saveLocation(Map<String, dynamic> weatherData) async {
    try {
      await _savingData.saveLocationToBackend(weatherData);
      setState(() {}); // Refresh UI after saving
    } catch (e) {
      debugPrint("Error saving location: $e");
    }
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
                title: Text(
                  fullName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  userEmail,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/weather_page.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: SafeArea(
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
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
                            onPressed: () => _showProfileOptions(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                            final List<dynamic> suggestions =
                                await weatherService.getCitySuggestions(input);

                            return suggestions.map((city) {
                              final String cityName = city['name'];
                              final String country = city['country'];

                              return ListTile(
                                title: Text(
                                  '$cityName, $country',
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: () async {
                                  // Fetch live weather
                                  final weatherData = await weatherService
                                      .fetchLiveWeather(cityName);

                                  // ADDED BACK: Save to Supabase
                                  await _saveLocation(weatherData);

                                  if (context.mounted) {
                                    controller.closeView(cityName);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WeatherPage(
                                          weatherData: weatherData,
                                          cityName: cityName,
                                        ),
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                              child: Text(
                                "No locations saved yet",
                                style: TextStyle(color: Colors.white),
                              ),
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
                            final savedCityName = item['weatherData']?['location']?['name'] ?? item['country'] ?? 'Unknown';
                            final locationKey = item['high_low'] ?? savedCityName;

                            return Dismissible(
                              key: Key(locationKey + index.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFF4D4D), Color(0xFFB71C1C)],
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 24),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete_rounded, color: Colors.white, size: 30),
                                    SizedBox(height: 4),
                                    Text(
                                      'Remove',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              confirmDismiss: (_) async {
                                return await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    backgroundColor: const Color.fromARGB(255, 2, 17, 29),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    title: const Text('Remove Location', style: TextStyle(color: Colors.white)),
                                    content: Text(
                                      'Remove $savedCityName from saved locations?',
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(ctx).pop(false),
                                        child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(ctx).pop(true),
                                        child: const Text('Remove', style: TextStyle(color: Colors.redAccent)),
                                      ),
                                    ],
                                  ),
                                ) ?? false;
                              },
                              onDismissed: (_) async {
                                await _savingData.deleteLocation(locationKey);
                                setState(() {});
                              },
                              child: profileGlassSquare(
                                context: context,
                                destinationPage: WeatherPage(
                                  weatherData: item['weatherData'],
                                  cityName: savedCityName,
                                ),
                                country: item['country'] ?? 'Unknown',
                                time: "Saved Location",
                                detail: item['detail'] ?? 'N/A',
                                temp: item['temp'] ?? '--°',
                                location: item['high_low'] ?? 'Unknown',
                              ),
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
        ),
      ),
    );
  }
}