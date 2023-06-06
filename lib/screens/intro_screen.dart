import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste/routes/route_helper.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.offAllNamed(RouteHelper.catalog());
    });
    return const Scaffold();
  }
}