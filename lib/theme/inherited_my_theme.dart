import 'package:flutter/material.dart';
import 'themes_impl/my_theme_data.dart';

class InheritedMyTheme extends InheritedWidget {
  final MyThemeData data;
  const InheritedMyTheme({
    required this.data,
    required super.child,
    super.key,
  });
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>     
      oldWidget != this;
}