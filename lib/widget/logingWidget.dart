import 'package:flutter/material.dart';

Widget logingWidget({
  required String label,
  required IconData icon,
  required TextEditingController controller,
  bool isPassword = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: TextField(
      style: TextStyle(
        color: Colors.white
      ),
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: label,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      ),
    ),
  );
}
