import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30.h,
            left: 20.w,
            right: 20.w,
            child: Transform.rotate(
              angle: -0.05,
              child: Opacity(
                opacity: 0.10,
                child: Container(
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "class Developer {",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "  void learn() {",
                        style: TextStyle(
                          color: Colors.purple,
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "    print(\"Keep Coding \");",
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "  }",
                        style: TextStyle(
                          color: Colors.purple,
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 20.h,
            child: Image.asset(
              "assets/icons/mora logo 5.png",
              width: 150.w,
              height: 100.h,
            ),
          ),
        ],
      ),
    );
  }
}
