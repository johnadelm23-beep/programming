import 'dart:math';

import 'package:flutter/material.dart';
import 'package:programmin/features/edit/ui/widgets/models/dots_model.dart';

class CustomFloatingDots extends StatelessWidget {
  const CustomFloatingDots({
    super.key,
    required this.floatController,
    required this.size,
    required this.dots,
  });
  final AnimationController floatController;
  final Size size;
  final List<Dot> dots;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: floatController,
      builder: (_, _) {
        return Stack(
          children: dots.map((d) {
            final t = floatController.value * 2 * pi * d.speed;

            return Positioned(
              left: d.dx * size.width + sin(t) * 20,
              top: d.dy * size.height + cos(t) * 20,
              child: Container(
                width: d.size,
                height: d.size,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
