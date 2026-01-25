import 'package:flutter/material.dart';
import 'package:wheather_application/profilePage.dart';
import 'package:wheather_application/widget/logingWidget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/logingPage.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              opacity: AlwaysStoppedAnimation(1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Back,',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color.fromARGB(255, 2, 1, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Login to your account to continue',
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 2, 1, 1)),
                ),
                SizedBox(height: 20),
                logingWidget(
                  label: 'Email',
                  icon: Icons.email,
                  controller: TextEditingController(),
                ),
                SizedBox(height: 20),
                logingWidget(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: TextEditingController(),
                  isPassword: true,
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.6),
                      shadowColor: Colors.black.withOpacity(1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 1, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.6),
                      shadowColor: Colors.black.withOpacity(1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 1, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
