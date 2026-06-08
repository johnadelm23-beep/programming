import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomQouteCard extends StatelessWidget {
  const CustomQouteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Icon(Icons.lightbulb_rounded, size: 32.sp, color: Colors.amber),
          SizedBox(height: 14.h),
          Text(
            '"Programming is not about what you know, it is about what you can figure out."',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.6),
          ),
        ],
      ),
    );
  }
}
