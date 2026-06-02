import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomQouteCard extends StatelessWidget {
  const CustomQouteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Column(
        children: [
          const Icon(IconlyBold.heart, color: AppColors.primaryPurple),
          SizedBox(height: 10.h),
          Text(
            "Programming is not about syntax. It's about thinking.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 13.sp, height: 1.5),
          ),
        ],
      ),
    );
  }
}
