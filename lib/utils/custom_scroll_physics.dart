import 'package:flutter/widgets.dart';

class CustomScrollPhysics extends BouncingScrollPhysics { 
  final Function outerController;
  
  const CustomScrollPhysics({required this.outerController, ScrollPhysics? parent}): super(parent: parent);
  
  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
        outerController: outerController, parent: buildParent(ancestor));
  }

  @override 
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if (position.pixels >= position.maxScrollExtent && velocity >= 0.0) {
      outerController(velocity);
    }
    return super.createBallisticSimulation(position, velocity);
  }
}