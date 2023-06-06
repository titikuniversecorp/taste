import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_theme_data.dart';

final lightAppTheme = MyThemeData(
  themeData: ThemeData(
    useMaterial3: true,
    // platform: TargetPlatform.iOS,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(
      textTheme: CupertinoTextThemeData(), // This is required
    ),
  ),
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFF5F5F5),
  frontColor: const Color(0xFFFFFFFF),
  iconColor: const Color(0xFF212121),
  brandColor: const Color(0xFFFDBF30),
  shadowColor: const Color(0xFFE8E8E8),
  textTheme: TextTheme(
    titleMedium: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
    titleSmall: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
    labelMedium: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
    labelSmall: TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 16,
      color: Colors.black.withOpacity(.6)
    ),
    bodyMedium: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 16,
      color: Colors.black
    ),
    bodySmall: const TextStyle(
      fontFamily: 'Cera Pro',
      fontSize: 14,
      color: Colors.black
    )
  )
);