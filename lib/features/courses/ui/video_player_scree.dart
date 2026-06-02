import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:programmin/core/theme/app_colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
      ),
    );

    controller.loadVideoById(videoId: widget.videoId);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Course Video",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(IconlyLight.arrow_left_2, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.primaryPurple.withOpacity(0.2),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: YoutubePlayer(
                  controller: controller,
                  aspectRatio: 16 / 9,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPurple.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          IconlyBold.play,
                          color: AppColors.primaryPurple,
                          size: 20.sp,
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Expanded(
                        child: Text(
                          "Course Lesson",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    "Watch the lesson carefully and continue learning through the playlist.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13.sp,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: AppColors.primaryPurple.withOpacity(0.08),
              ),
              child: Row(
                children: [
                  Icon(
                    IconlyLight.info_circle,
                    color: AppColors.primaryPurple,
                    size: 20.sp,
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: Text(
                      "After finishing this lesson, go back and open the next video.",
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),
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
