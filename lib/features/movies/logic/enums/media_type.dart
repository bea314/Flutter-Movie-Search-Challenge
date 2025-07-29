enum MediaType { movie, series, episode, unknown }

extension MediaTypeExtension on MediaType {
  String get value {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.series:
        return 'series';
      case MediaType.episode:
        return 'episode';
      case MediaType.unknown:
        return 'unknown';
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
      case '':
        return MediaType.unknown; // Assuming 'unknown' is a valid type
      default:
        throw ArgumentError('Unknown MediaType: $type');
    }
  }
}
