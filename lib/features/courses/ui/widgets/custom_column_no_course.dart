import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomColumnNoCourse extends StatelessWidget {
  const CustomColumnNoCourse({super.key, required this.isAdmin});
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/splash/code.json", width: 220.w),

        SizedBox(height: 20.h),

        Text(
          "No Courses Yet",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          isAdmin
              ? "Add your first playlist from admin panel"
              : "Wait for new content",
          style: TextStyle(color: Colors.white70, fontSize: 13.sp),
        ),
      ],
    );
  }
}
