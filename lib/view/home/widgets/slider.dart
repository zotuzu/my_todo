import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_todo/utils/colors.dart';

final List<IconData> icons = [
  CupertinoIcons.home,
  CupertinoIcons.person_fill,
  CupertinoIcons.settings,
  CupertinoIcons.info_circle_fill,
];

final List<String> texts = [
  "Home",
  "Profile",
  "Settings",
  "Details",
];

class MySlider extends StatelessWidget {
  const MySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: MyColors.primaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/img/main.png'),
              ),
              SizedBox(height: 24),
              Text(
                "Welcome to",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "My ToDo App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "App version 1.0.0",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
