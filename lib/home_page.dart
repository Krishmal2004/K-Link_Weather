import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheather_application/main.dart';
import 'package:wheather_application/weather_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/home_page.jpg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.dew_point, color: Colors.white, size: 30),
                        SizedBox(width: 10),
                        Text(
                          'K-Link',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      'WEATHER AT\nA GLANCE,\nANYTIME,\nANYWHERE.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w400,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "We're here to keep you updated on the \nweather,so you can plan your day\nwithout surprises.",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 100),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      WeatherPage(),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    var curve = Curves.easeOut;
                                    var curveTween = CurveTween(curve: curve);
                                    var slideTween = Tween<Offset>(
                                      begin: Offset(0, 0.1),
                                      end: Offset.zero,
                                    ).chain(curveTween);
                                    return FadeTransition(
                                      opacity: animation.drive(curveTween),
                                      child: SlideTransition(
                                        position: animation.drive(slideTween),
                                        child: child,
                                      ),
                                    );
                                  },
                              transitionDuration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '<<< ',
                                style: TextStyle(
                                  color: Colors.white24,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.3),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'GET STARTED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Text(
                                ' >>>',
                                style: TextStyle(
                                  color: Colors.white24,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
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
