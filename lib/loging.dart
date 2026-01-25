import 'package:flutter/material.dart';
import 'package:wheather_application/widget/logingWidget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 17, 29),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back,',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Login to your account to continue',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 20,),
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
            ],
          ),
        ),
      ),
    );
  }
}
