class YoutubeVideo {
  final String title;
  final String videoId;
  final String thumbnail;

  YoutubeVideo({
    required this.title,
    required this.videoId,
    required this.thumbnail,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    return YoutubeVideo(
      title: snippet['title'] ?? '',
      videoId: snippet['resourceId']?['videoId'] ?? '',
      thumbnail: snippet['thumbnails']?['high']?['url'] ?? '',
    );
  }
}
