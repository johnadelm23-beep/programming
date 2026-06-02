import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/core/theme/app_colors.dart';

class CustomAppBarProfile extends StatelessWidget {
  const CustomAppBarProfile({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: AppColors.primaryPurple,

          backgroundImage: user?.photoURL != null
              ? NetworkImage(user!.photoURL!)
              : null,

          child: user?.photoURL == null ? Icon(IconlyLight.profile) : null,
        ),

        SizedBox(width: 12.w),
        Text(
          "My Profile",
          style: TextStyle(fontSize: 30.sp, color: Colors.white),
        ),
      ],
    );
  }
}
