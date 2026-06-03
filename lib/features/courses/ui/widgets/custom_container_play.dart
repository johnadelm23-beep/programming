import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomContainerPlay extends StatelessWidget {
  const CustomContainerPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryPurple.withOpacity(0.4),
            AppColors.primaryBlue.withOpacity(0.2),
          ],
        ),
      ),
      child: const Icon(IconlyBold.play, color: Colors.white),
    );
  }
}
