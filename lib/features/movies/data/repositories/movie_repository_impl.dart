import '../../logic/entities/movie.dart';
import '../../logic/entities/movie_detail.dart';
import '../../logic/enums/media_type.dart';
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
      rated:     dto.rated,
      released:  dto.released,
      runtime:   dto.runtime,
      genre:     dto.genre,
      director:  dto.director,
      writer:    dto.writer,
      actors:    dto.actors,
      language:  dto.language,
      country:   dto.country,
      awards:    dto.awards,
      ratings:   dto.ratings,
      metascore: dto.metascore,
      imdbRating: dto.imdbRating,
      imdbVotes:  dto.imdbVotes,
      type:       dto.type?.value,
      dvd:        dto.dvd,
      boxOffice:  dto.boxOffice,
      production: dto.production,
      website:    dto.website,
      response:   dto.response,
    );
  }

  @override
  Future<List<Movie>> searchMovies({
    required String query,
    MediaType? type,
    String? year,
    int page = 1,
  }) async {
    // 1) Call remote data source
    final models = await remote.searchMoviesApi(
      query: query,
      type:  type?.value,
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
