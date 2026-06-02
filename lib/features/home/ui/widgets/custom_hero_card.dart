import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomHeroCard extends StatelessWidget {
  const CustomHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.r),
        gradient: const LinearGradient(
          colors: [AppColors.primaryPurple, AppColors.primaryBlue],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(IconlyBold.game, color: Colors.white, size: 36),
          SizedBox(height: 14.h),
          Text(
            "Level Up Your Coding Skills",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Explore programming in a fun and interactive way. Learn by building and experimenting.",
            style: TextStyle(
              color: Colors.white.withOpacity(.9),
              fontSize: 13.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
