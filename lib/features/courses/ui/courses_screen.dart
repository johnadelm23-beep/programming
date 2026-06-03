import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/courses/ui/course_preview.dart';
import 'package:programmin/features/courses/ui/models/course.dart';
import 'package:programmin/features/courses/ui/models/fire_store_service.dart';
import 'package:programmin/features/home/cubit/cubit/home_cubit.dart';

class CoursesScreen extends StatelessWidget {
  CoursesScreen({super.key});

  final service = CoursesService();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<HomeCubit>().userData;
    final isAdmin = user?.isAdmin ?? false;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Icon(IconlyBold.play, color: AppColors.primaryPurple),
            SizedBox(width: 8.w),
            const Text("Courses", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),

      body: StreamBuilder<List<CourseModel>>(
        stream: service.getCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final courses = snapshot.data ?? [];

          if (courses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/splash/code.json", width: 220.w),

                  SizedBox(height: 20.h),

                  Text(
                    "No Courses Yet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    isAdmin
                        ? "Add your first playlist from admin panel"
                        : "Wait for new content",
                    style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return CourseCard(course: courses[index], isAdmin: isAdmin);
            },
          );
        },
      ),
    );
  }
}
