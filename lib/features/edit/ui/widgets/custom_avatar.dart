import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key, required this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.9, end: 1.05),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: CircleAvatar(
            radius: 45.r,
            backgroundColor: AppColors.primaryPurple,
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : null,
            child: user?.photoURL == null
                ? Text(
                    (user?.email ?? "U")[0].toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 26.sp),
                  )
                : null,
          ),
        );
      },
    );
  }
}
