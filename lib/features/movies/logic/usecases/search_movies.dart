import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;
  SearchMovies(this.repository);

  Future<List<Movie>> call(String query) {
    return repository.searchMovies(query: query);
  }
}
