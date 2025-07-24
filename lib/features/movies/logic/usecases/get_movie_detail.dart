import '../../logic/entities/movie_detail.dart';
import '../../logic/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;
  GetMovieDetail(this.repository);

  /// Gives [MovieDetail] or throws [Exception]
  Future<MovieDetail> call(String id) {
    return repository.getMovieDetail(id);
  }
}
