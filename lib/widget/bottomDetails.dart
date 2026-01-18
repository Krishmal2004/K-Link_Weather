import 'package:flutter/material.dart';

Widget bottomDetails(String time, IconData icon, String value) {
  return Column(
    children: [
      Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              time,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10,),
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(height: 10,),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
