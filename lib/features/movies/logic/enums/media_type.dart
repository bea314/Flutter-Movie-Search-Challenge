enum MediaType { movie, series, episode }

extension MediaTypeExtension on MediaType {
  String get value {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.series:
        return 'series';
      case MediaType.episode:
        return 'episode';
    }
  }

  static MediaType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'movie':
        return MediaType.movie;
      case 'series':
        return MediaType.series;
      case 'episode':
        return MediaType.episode;
      default:
        throw ArgumentError('Unknown MediaType: $type');
    }
  }
}
