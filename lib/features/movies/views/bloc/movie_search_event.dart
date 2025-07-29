import '../../logic/enums/media_type.dart';

/// when search requested
class SearchRequested {
  final String query;
  final List<MediaType> types;
  final String? year;
  final int page;
  SearchRequested(this.query, {
    this.types = const [],
    this.year,
    this.page = 1,
  });
}
