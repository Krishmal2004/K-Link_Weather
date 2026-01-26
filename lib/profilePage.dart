import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheather_application/loging.dart';
import 'package:wheather_application/weather_page.dart';
import 'package:wheather_application/widget/profile_glassSquare.dart';
import 'package:wheather_application/services/AuthService.dart';

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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search for a city',
                            hintStyle: TextStyle(color: Colors.white70),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white70,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            profileGlassSquare(
                              context: context,
                              destinationPage: WeatherPage(),
                              country: 'Sri Lanka',
                              time: 'My Location',
                              detail: 'party Cloudy',
                              temp: '24°',
                              location: 'H:31° L:21°',
                            ),
                            profileGlassSquare(
                              context: context,
                              destinationPage: WeatherPage(),
                              country: 'Sri Lanka',
                              time: 'My Location',
                              detail: 'party Cloudy',
                              temp: '24°',
                              location: 'H:31° L:21°',
                            ),
                            profileGlassSquare(
                              context: context,
                              destinationPage: WeatherPage(),
                              country: 'Sri Lanka',
                              time: 'My Location',
                              detail: 'party Cloudy',
                              temp: '24°',
                              location: 'H:31° L:21°',
                            ),
                            profileGlassSquare(
                              context: context,
                              destinationPage: WeatherPage(),
                              country: 'Sri Lanka',
                              time: 'My Location',
                              detail: 'party Cloudy',
                              temp: '24°',
                              location: 'H:31° L:21°',
                            ),
                          ],
                        ),
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
