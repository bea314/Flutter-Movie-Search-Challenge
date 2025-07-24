import '../entities/movie_detail.dart';

abstract class MovieRepository {
  /// Throw [Exception] if fails.
  Future<MovieDetail> getMovieDetail(String id);
}
