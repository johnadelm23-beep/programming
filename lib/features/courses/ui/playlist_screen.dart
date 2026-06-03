import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:programmin/core/constants/api_keys.dart';
import 'package:programmin/core/services/youtube_service.dart';
import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/courses/ui/models/youtube_video.dart';
import 'package:programmin/features/courses/ui/video_player_scree.dart';
import 'package:programmin/features/courses/ui/widgets/custom_container_playlist.dart';

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

                child: CustomContainerPlaylist(video: video),
              );
            },
          );
        },
      ),
    );
  }
}
