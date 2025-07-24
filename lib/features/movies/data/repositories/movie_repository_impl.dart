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
}
