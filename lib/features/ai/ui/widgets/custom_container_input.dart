import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class CustomContainerInput extends StatelessWidget {
  const CustomContainerInput({super.key, this.onTap, this.controller});
  final void Function()? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(color: Colors.black.withOpacity(.4)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              //
              controller: controller,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: "Ask anything...",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.deepPurple,
              child: Icon(IconlyLight.send, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
