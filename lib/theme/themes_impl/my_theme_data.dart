import 'package:flutter/material.dart';

class MyThemeData {
  late ThemeData themeData; // important!
  final Brightness brightness;
  final Color backgroundColor;
  final Color frontColor;
  final Color iconColor;
  final Color brandColor;
  final Color shadowColor;
  final TextTheme textTheme;

  MyThemeData({
    required this.themeData,
    required this.brightness,
    required this.backgroundColor,
    required this.frontColor,
    required this.iconColor,
    required this.brandColor,
    required this.shadowColor,
    required this.textTheme
  });
}