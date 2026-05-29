import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class CustomTextFormFieldName extends StatelessWidget {
  const CustomTextFormFieldName({
    super.key,
    this.user,
    this.readOnly = false,
    required this.icon,
    this.hintText,
    this.controller,
  });
  final User? user;
  final bool readOnly;
  final IconData icon;
  final String? hintText;
  final TextEditingController? controller;
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
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          prefixIcon: Icon(IconlyLight.profile, color: Colors.white),
          hintText: "Enter your name",
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
