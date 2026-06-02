import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustmCardContainer extends StatelessWidget {
  const CustmCardContainer({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryPurple),
            SizedBox(height: 10.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
