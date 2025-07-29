import '../entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class MovieRepository {
  /// Search of movie list 
  /// Throw [Exception] if fails.
  Future<List<Movie>> searchMovies({
    required String query,
    String? type,
    String? year,
    int page,
  });
  /// Search for movie detail
  /// Throw [Exception] if fails.
  Future<MovieDetail> getMovieDetail(String id);
}
