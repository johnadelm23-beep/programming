import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/courses/ui/models/youtube_video.dart';

class CustomContainerPlaylist extends StatelessWidget {
  const CustomContainerPlaylist({super.key, required this.video});
  final YoutubeVideo video;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryPurple.withOpacity(0.2)),
      ),

      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Stack(
              children: [
                Image.network(
                  video.thumbnail,
                  width: 120.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                ),

                Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.25)),
                ),

                const Positioned.fill(
                  child: Icon(IconlyBold.play, color: Colors.white, size: 30),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8.h),

                Row(
                  children: [
                    Icon(IconlyLight.play, size: 16, color: Colors.green),
                    SizedBox(width: 6.w),
                    Text(
                      "Watch Now",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Icon(IconlyLight.arrow_right_2, color: Colors.grey),
        ],
      ),
    );
  }
}
