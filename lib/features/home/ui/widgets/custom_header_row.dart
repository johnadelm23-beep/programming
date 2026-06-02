import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeaderRow extends StatelessWidget {
  const CustomHeaderRow({super.key, required this.user});
  final String user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey Developer 👋",
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
              SizedBox(height: 4.h),
              Text(
                user,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
