import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomContainerList extends StatelessWidget {
  const CustomContainerList({
    super.key,
    this.icon,
    this.onTap,
    required this.title,
    required this.isDestructive,
  });
  final IconData? icon;
  final void Function()? onTap;
  final String title;
  final bool isDestructive;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDestructive
                    ? Colors.redAccent
                    : AppColors.primaryPurple,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isDestructive ? Colors.redAccent : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(IconlyLight.arrow_right_2, color: Colors.grey, size: 18.r),
            ],
          ),
        ),
      ),
    );
  }
}
