import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/about%20app/ui/widgets/custom_dev_container.dart';
import 'package:programmin/features/about%20app/ui/widgets/custom_floating_icons.dart';
import 'package:programmin/features/about%20app/ui/widgets/custom_glass_card.dart';
import 'package:programmin/features/about%20app/ui/widgets/custom_heart_container.dart';
import 'package:programmin/features/about%20app/ui/widgets/custom_join_button.dart';
import 'package:programmin/features/about%20app/ui/widgets/models/floating_icon.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen>
    with TickerProviderStateMixin {
  late final AnimationController floatController;
  late final AnimationController joinController;

  late final Animation<double> fade;
  late final Animation<Offset> slide;

  final List<FloatingIcon> icons = [];

  @override
  void initState() {
    super.initState();

    floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    joinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: floatController, curve: Curves.easeOut));

    slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: floatController, curve: Curves.easeOut));

    icons.addAll(
      List.generate(12, (index) {
        return FloatingIcon(
          dx: Random().nextDouble(),
          dy: Random().nextDouble(),
          speed: Random().nextDouble() * 2 + 0.5,
          size: Random().nextDouble() * 30 + 18,
        );
      }),
    );
  }

  @override
  void dispose() {
    floatController.dispose();
    joinController.dispose();
    super.dispose();
  }

  void _onJoinTap() {
    joinController.forward(from: 0);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Welcome to Developer Community!"),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF060913)],
              ),
            ),
          ),

          CustomFloatingIcons(
            size: size,
            icons: icons,
            floatController: floatController,
          ),
          SafeArea(
            child: FadeTransition(
              opacity: AlwaysStoppedAnimation(1),
              child: SlideTransition(
                position: AlwaysStoppedAnimation(Offset.zero),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),

                      CustomHeartContainer(),
                      SizedBox(height: 18.h),

                      Text(
                        "Developer Community",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 6.h),

                      Text(
                        "Eat(),Sleep(),Code(),Repeat()",
                        style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                      ),

                      SizedBox(height: 30.h),

                      CustomGlassCard(),

                      SizedBox(height: 30.h),

                      CustomDevContainer(),
                      const Spacer(),

                      CustomJoinButton(
                        joinController: joinController,
                        onTap: _onJoinTap,
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
