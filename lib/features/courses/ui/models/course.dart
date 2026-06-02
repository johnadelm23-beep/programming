class CourseModel {
  final String id;
  final String playlistId;
  final String title;
  final String description;

  const CourseModel({
    required this.id,
    required this.playlistId,
    required this.title,
    required this.description,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json, String id) {
    return CourseModel(
      id: id,
      playlistId: json['playlistId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "playlistId": playlistId,
      "title": title,
      "description": description,
    };
  }

  CourseModel copyWith({
    String? id,
    String? playlistId,
    String? title,
    String? description,
  }) {
    return CourseModel(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
