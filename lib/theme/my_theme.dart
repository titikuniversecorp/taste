import 'package:flutter/material.dart';

import 'inherited_my_theme.dart';
import 'themes_impl/my_theme_data.dart';

final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
void toggleAppTheme() {
  _notifier.value = _notifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
}
ThemeMode get currentAppTheme => _notifier.value;

class MyTheme extends StatelessWidget {
  final MyThemeData light;
  final MyThemeData dark;
  final Widget child;

  const MyTheme({super.key, required this.light, required this.dark, required this.child});

  @override
  Widget build(BuildContext context) {
    // final brightness = MediaQuery.of(context).platformBrightness;
    // final data = brightness == Brightness.light ? light : dark;
     
    return ValueListenableBuilder(
      valueListenable: _notifier,
      builder: (_, ThemeMode mode, __) {
        return InheritedMyTheme(
          data: mode == ThemeMode.light ? light : dark,
          child: Theme(
            data: mode == ThemeMode.light ? light.themeData : dark.themeData,
            child: child,
          ),
        );
      }
    );
  }
  static MyThemeData of(BuildContext context){
    final theme = Theme.of(context);
    return context
        .dependOnInheritedWidgetOfExactType<InheritedMyTheme>()!
        .data..themeData = theme;
  }
}