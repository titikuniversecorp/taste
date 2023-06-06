
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_theme_data.dart';

final darkAppTheme = MyThemeData(
  themeData: ThemeData(
    useMaterial3: true,
    // platform: TargetPlatform.iOS,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(
      textTheme: CupertinoTextThemeData(), // This is required
    ),
  ),
  brightness: Brightness.dark,
  backgroundColor: const Color.fromARGB(255, 36, 36, 37), //const Color(0xFF1f1f1f),
  frontColor: const Color.fromARGB(255, 47, 47, 47),
  iconColor: const Color(0xFF818181),
  brandColor: const Color(0xFFFDBF30),
  shadowColor: const Color(0xFF1E1E1E),
  textTheme: TextTheme(
    titleMedium: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    titleSmall: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    labelMedium: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    labelSmall: TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 16,
      color: Colors.grey.withOpacity(.8)
    ),
    bodyMedium: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 16,
      color: Colors.white
    ),
    bodySmall: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 14,
      color: Colors.white
    )
  )
);