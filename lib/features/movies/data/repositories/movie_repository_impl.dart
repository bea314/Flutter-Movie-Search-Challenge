import '../../logic/entities/movie.dart';
import '../../logic/entities/movie_detail.dart';
import '../../logic/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  MovieRepositoryImpl(this.remote);

  @override
  Future<MovieDetail> getMovieDetail(String id) async {
    final dto = await remote.getMovieDetailApi(id);
    return MovieDetail(
      imdbId: dto.imdbId,
      title:  dto.title,
      year:   dto.year,
      plot:   dto.plot,
      poster: dto.poster,
    );
  }

  @override
  Future<List<Movie>> searchMovies({
    required String query,
    String? type,
    String? year,
    int page = 1,
  }) async {
    // 1) Call remote data source
    final models = await remote.searchMoviesApi(
      query: query,
      type:  type,
      year:  year,
      page:  page,
    );

    // 2) Map DTOs to Domain entities
    return models.map((m) => Movie(
      imdbId:   m.imdbId,
      title:    m.title,
      year:     m.year,
      posterUrl:m.poster,
    )).toList();
  }
}
