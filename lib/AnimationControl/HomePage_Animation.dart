import 'package:flutter/material.dart';

class HomePageAnimation {
  late AnimationController controller;
  late Animation<double> heightAnimation;

  HomePageAnimation({
    required TickerProvider vsync,
    double beginHeight = 0.0,
    double endHeight = 0.60,
  }) {
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: vsync,
    );

    // Animation for height expansion
    heightAnimation = Tween<double>(
      begin: beginHeight,
      end: endHeight,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}
