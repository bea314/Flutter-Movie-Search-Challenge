import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;
  SearchMovies(this.repository);

  Future<List<Movie>> call({
    required String query,
    String? type,
    String? year,
    int page = 1,
  }) {
    return repository.searchMovies(
      query: query,
      type:  type,
      year:  year,
      page:  page,
    );
  }
}
