class MediaItem {
  final String title;
  final String posterPath;

  MediaItem({required this.title, required this.posterPath});

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      title: json['title'] ?? json['name'] ?? 'No Title',
      posterPath: json['poster_path'] ?? '',
    );
  }
}
