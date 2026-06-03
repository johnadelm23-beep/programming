import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/courses/ui/models/course.dart';
import 'package:programmin/features/courses/ui/courses_screen.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final bool isAdmin;

  const CourseCard({super.key, required this.course, required this.isAdmin});

  Future<void> _delete(BuildContext context) async {
    Future<bool?> showDeleteCourseDialog(BuildContext context) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(20.r),
                // border: Border.all(color: Colors.red.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ICON
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(0.1),
                    ),
                    child: Icon(
                      IconlyLight.delete,
                      color: Colors.redAccent,
                      size: 34.r,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  Text(
                    "Delete Course?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    "This action cannot be undone. The course will be permanently removed.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13.sp,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 22.h),

                  // BUTTONS
                  Row(
                    children: [
                      // CANCEL
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context, false),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 12.w),

                      // DELETE
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context, true),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.redAccent, Colors.red.shade700],
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconlyBold.delete,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    final confirm = await showDeleteCourseDialog(context);

    if (confirm != true) return;
    await FirebaseFirestore.instance
        .collection("courses")
        .doc(course.id)
        .delete();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Deleted")));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PlaylistScreen(playlistId: course.playlistId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          ),
        );
      },

      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.primaryPurple.withOpacity(0.25)),
        ),

        child: Row(
          children: [
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryPurple.withOpacity(0.4),
                    AppColors.primaryBlue.withOpacity(0.2),
                  ],
                ),
              ),
              child: const Icon(IconlyBold.play, color: Colors.white),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.sp,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    course.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    children: [
                      Icon(IconlyLight.video, color: Colors.purple, size: 14.r),

                      SizedBox(width: 6.w),

                      Text(
                        "Open Playlist",
                        style: TextStyle(color: Colors.purple, fontSize: 12.sp),
                      ),

                      const Spacer(),

                      if (isAdmin)
                        GestureDetector(
                          onTap: () => _delete(context),
                          child: Icon(
                            IconlyBroken.delete,
                            color: Colors.red,
                            size: 18.r,
                          ),
                        )
                      else
                        const Icon(
                          IconlyLight.arrow_right_2,
                          color: Colors.white38,
                          size: 18,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
