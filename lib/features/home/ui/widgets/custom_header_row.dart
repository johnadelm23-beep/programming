import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeaderRow extends StatelessWidget {
  const CustomHeaderRow({super.key, required this.user});

  final String user;

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Hi,Developer Good Morning ☀️";
    } else if (hour < 18) {
      return "Hi,Developer Good Afternoon 😎";
    }
    return "Hi,Developer Good Evening 🌙";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getGreeting(),
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
              SizedBox(height: 4.h),
              Text(
                user,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Ready for today's coding adventure?",
                style: TextStyle(color: Colors.white54, fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
