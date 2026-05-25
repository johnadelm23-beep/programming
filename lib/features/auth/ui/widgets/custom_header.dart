import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 40.h,
            left: 20.w,
            right: 20.w,
            child: Opacity(
              opacity: 0.15,
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "class Developer {",
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      "  void code() {",
                      style: TextStyle(
                        color: Colors.purple,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      "    print(\"Keep Coding\");",
                      style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text("  }", style: TextStyle(color: Colors.purple)),
                    Text("}", style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            child: Container(
              width: 80.w,
              height: 70.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryPurple, AppColors.primaryBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(Icons.code, color: Colors.white, size: 40.r),
            ),
          ),
        ],
      ),
    );
  }
}
