import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/features/about%20app/ui/widgets/models/floating_icon.dart';

class CustomFloatingIcons extends StatelessWidget {
  const CustomFloatingIcons({
    super.key,
    required this.size,
    required this.icons,
    required this.floatController,
  });
  final Size size;
  final List<FloatingIcon> icons;
  final AnimationController floatController;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: floatController,
      builder: (context, _) {
        return Stack(
          children: icons.map((icon) {
            final t = floatController.value * 2 * pi * icon.speed;

            return Positioned(
              left: icon.dx * size.width + sin(t) * 25,
              top: icon.dy * size.height + cos(t) * 25,
              child: Opacity(
                opacity: 0.08,
                child: Icon(
                  icon.dx > 0.5 ? IconlyBold.activity : IconlyBold.category,
                  size: icon.size,
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
