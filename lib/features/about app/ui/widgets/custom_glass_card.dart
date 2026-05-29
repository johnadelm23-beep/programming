import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGlassCard extends StatelessWidget {
  const CustomGlassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Text(
        "Demo app for learning programming and be THE BEST! ",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey, fontSize: 13.sp, height: 1.6),
      ),
    );
  }
}
