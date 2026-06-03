import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/constants/api_keys.dart';
import 'package:programmin/core/services/youtube_service.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/courses/ui/models/youtube_video.dart';
import 'package:programmin/features/courses/ui/video_player_scree.dart';

class PlaylistScreen extends StatefulWidget {
  final String playlistId;

  const PlaylistScreen({super.key, required this.playlistId});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late Future<List<YoutubeVideo>> videos;

  final service = YoutubeService(ApiKeys.youtube);

  @override
  void initState() {
    super.initState();
    videos = service.fetchPlaylist(widget.playlistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(IconlyLight.arrow_left_2, color: Colors.white),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          "Course Playlist",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: FutureBuilder<List<YoutubeVideo>>(
        future: videos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final list = snapshot.data ?? [];

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: list.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),

            itemBuilder: (context, index) {
              final video = list[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          VideoPlayerScreen(videoId: video.videoId),
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
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.primaryPurple.withOpacity(0.2),
                    ),
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
                              child: Container(
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ),

                            const Positioned.fill(
                              child: Icon(
                                IconlyBold.play,
                                color: Colors.white,
                                size: 30,
                              ),
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
                                Icon(
                                  IconlyLight.play,
                                  size: 16,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "Watch Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Icon(IconlyLight.arrow_right_2, color: Colors.grey),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
