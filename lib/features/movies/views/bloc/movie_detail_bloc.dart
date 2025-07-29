import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/movie_detail_model.dart';
import '../../logic/enums/media_type.dart';
import '../../logic/usecases/get_movie_detail.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<DetailRequested, MovieDetailState> {
  final GetMovieDetail _getDetail;

  MovieDetailBloc(this._getDetail) : super(MovieDetailInitial()) {
    on<DetailRequested>(_onDetailRequested);
  }

  Future<void> _onDetailRequested(
    DetailRequested event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    try {
      final entity = await _getDetail(event.movieId);
      final model = MovieDetailModel(
        response: entity.response,
        imdbId:   entity.imdbId,
        title:    entity.title,
        year:     entity.year,
        plot:     entity.plot,
        poster:   entity.poster,
        rated: entity.rated, 
        released: entity.released, 
        runtime: entity.runtime, 
        genre: entity.genre, 
        director: entity.director, 
        writer: entity.writer, 
        actors: entity.actors, 
        language: entity.language, 
        country: entity.country, 
        awards: entity.awards, 
        ratings: entity.ratings, 
        metascore: entity.metascore, 
        imdbRating: entity.imdbRating, 
        imdbVotes: entity.imdbVotes, 
        type: MediaTypeExtension.fromString(entity.type ?? ''),
        dvd: entity.dvd, 
        boxOffice: entity.boxOffice, 
        production: entity.production, 
        website: entity.website,
      );
      emit(MovieDetailLoaded(model));
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}
