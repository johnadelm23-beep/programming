import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';

class ContainerVersion extends StatelessWidget {
  const ContainerVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        "Version 1.0.0",
        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
      ),
    );
  }
}
