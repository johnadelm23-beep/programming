import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomFunCard extends StatelessWidget {
  const CustomFunCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(.15),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: const Icon(IconlyBold.play, color: AppColors.primaryPurple),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              "Start exploring new coding worlds and improve your skills daily",
              style: TextStyle(color: Colors.white70, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
