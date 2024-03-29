import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taste/controllers/cart_controller.dart';

import 'controllers/restaurant_controller.dart';
import 'helpers/dependencies.dart';
import 'routes/route_helper.dart';
import 'theme/my_theme.dart';
import 'theme/themes_impl/dark.dart';
import 'theme/themes_impl/light.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  init(sharedPreferences: prefs);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
        )
      );
    });

    // Эти GetBuilder нужны только чтобы эти контроллеры не удалялись из памяти (issue fix). По назначению не используется!
    return GetBuilder<RestaurantController>(
      builder: (_) {
        return GetBuilder<CartController>(
          builder: (_) {
            return GetMaterialApp(
              title: 'Taste',
              debugShowCheckedModeBanner: false,
              builder: (context, child) => MyTheme(
                light: lightAppTheme,
                dark: darkAppTheme,
                child: child ?? ErrorWidget('Child needed!')
              ),
              initialRoute: RouteHelper.initial(),
              getPages: RouteHelper.routes,
            );
          }
        );
      }
    );
  }
}