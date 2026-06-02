import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

import 'package:programmin/core/theme/app_colors.dart';

class AdminAddPlaylistScreen extends StatefulWidget {
  const AdminAddPlaylistScreen({super.key});

  @override
  State<AdminAddPlaylistScreen> createState() => _AdminAddPlaylistScreenState();
}

class _AdminAddPlaylistScreenState extends State<AdminAddPlaylistScreen> {
  final title = TextEditingController();
  final desc = TextEditingController();
  final playlist = TextEditingController();

  bool loading = false;

  Future<void> addCourse() async {
    if (title.text.isEmpty || desc.text.isEmpty || playlist.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() => loading = true);

    try {
      await FirebaseFirestore.instance.collection("courses").add({
        "title": title.text.trim(),
        "description": desc.text.trim(),
        "playlistId": playlist.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      title.clear();
      desc.clear();
      playlist.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.backgroundColor,
          content: Text(
            "Course Added",
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,

        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconlyBold.setting,
              color: AppColors.primaryPurple,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              "Admin Panel",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              // HEADER CARD
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryPurple.withOpacity(0.2),
                      AppColors.primaryBlue.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                      child: Icon(
                        IconlyBold.plus,
                        color: AppColors.primaryPurple,
                        size: 22.sp,
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create New Course",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Add YouTube playlist to your platform",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              _buildField(
                controller: title,
                label: "Course Title",
                icon: IconlyLight.edit,
              ),

              SizedBox(height: 15.h),

              _buildField(
                controller: desc,
                label: "Description",
                icon: IconlyLight.document,
                maxLines: 3,
              ),

              SizedBox(height: 15.h),

              _buildField(
                controller: playlist,
                label: "YouTube Playlist ID",
                icon: IconlyLight.video,
              ),

              SizedBox(height: 30.h),

              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryPurple.withOpacity(0.2)),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: AppColors.primaryPurple),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: loading ? null : addCourse,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 10,
        ),
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(IconlyBold.plus, size: 20.sp, color: Colors.white),
                  SizedBox(width: 8.w),
                  Text(
                    "Add Course",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
