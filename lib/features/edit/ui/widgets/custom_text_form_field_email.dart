import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class CustomTextFormFieldEmail extends StatelessWidget {
  const CustomTextFormFieldEmail({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: TextField(
        readOnly: true,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          prefixIcon: const Icon(IconlyLight.message, color: Colors.grey),
          hintText: user?.email ?? "",
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
