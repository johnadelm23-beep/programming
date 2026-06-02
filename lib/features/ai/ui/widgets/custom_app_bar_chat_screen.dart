import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class CustomAppBarChatScreen extends StatelessWidget {
  const CustomAppBarChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(IconlyBroken.category, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          // SizedBox(width: 5.w),
          Text(
            "Demo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
