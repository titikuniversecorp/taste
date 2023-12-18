import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste/routes/route_helper.dart';

import '../controllers/restaurant_controller.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _getData();
      Get.offAllNamed(RouteHelper.catalog());
    });
  }

  Future _getData() async {
    await Get.find<RestaurantController>().getRestaurans();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}