import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:programmin/features/courses/ui/models/youtube_video.dart';

class YoutubeService {
  final String apiKey;

  YoutubeService(this.apiKey);

  Future<List<YoutubeVideo>> fetchPlaylist(String playlistId) async {
    final url = Uri.parse(
      "https://www.googleapis.com/youtube/v3/playlistItems"
      "?part=snippet"
      "&maxResults=50"
      "&playlistId=$playlistId"
      "&key=$apiKey",
    );

    final response = await http.get(url);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return (data['items'] as List)
          .map((e) => YoutubeVideo.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load playlist");
    }
  }
}
