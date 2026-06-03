import 'package:flutter/material.dart';

class CustomAnimatedItem extends StatelessWidget {
  const CustomAnimatedItem({
    super.key,
    required this.index,
    required this.child,
  });
  final int index;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 350 + (index * 120)),
      tween: Tween(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 25),
            child: Transform.scale(scale: 0.95 + (value * 0.05), child: child),
          ),
        );
      },
    );
  }
}
