import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheather_application/widget/profile_glassSquare.dart';

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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Weather',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
                            offset: const Offset(0, 50),
                            color: const Color(0xFF1E1E1E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'Edit List',
                                child: Text(
                                  'Edit List',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'Notifications',
                                child: Text(
                                  'Notifications',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Search for a city',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            profileGlassSquare(
                              country: "Sri Lanka",
                              time: "7:36 AM",
                              detail: "Mostly Sunny",
                              temp: "24°",
                              location: "H:31° L:21°",
                              backgroundImage: 'assets/home_page.jpg',
                            ),
                            const SizedBox(height: 15),
                            profileGlassSquare(
                              country: "Cupertino",
                              time: "9:06 AM",
                              detail: "Partly Cloudy",
                              temp: "7°",
                              location: "H:19° L:5°",
                              backgroundImage: 'assets/home_page.jpg',
                            ),
                            const SizedBox(height: 15),
                            profileGlassSquare(
                              country: "New York",
                              time: "10:38 AM",
                              detail: "Clear",
                              temp: "-3°",
                              location: "H:0° L:-5°",
                              backgroundImage: 'assets/home_page.jpg',
                            ),
                            const SizedBox(height: 30),
                            profileGlassSquare(
                              country: "New York",
                              time: "10:38 AM",
                              detail: "Clear",
                              temp: "-3°",
                              location: "H:0° L:-5°",
                              backgroundImage: 'assets/home_page.jpg',
                            ),
                            const SizedBox(height: 10),
                            Text(
                              textAlign: TextAlign.start,
                              'Learn more about weather data and map data',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
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
          ],
        ),
      ),
    );
  }
}
