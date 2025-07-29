
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/features/movies/logic/enums/media_type.dart';

import '../../logic/usecases/search_movies.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<SearchRequested, MovieSearchState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(MovieSearchInitial()) {
    on<SearchRequested>(_onSearchRequested);
  }

  Future<void> _onSearchRequested(
    SearchRequested event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(MovieSearchLoading());
    try {
      // Only support one type param in OMDb, pick first if multiple provided
      // Because error: "Procedure or function SearchTitle has too many arguments specified"
      final typeParam = event.types.isNotEmpty
          ? event.types.firstOrNull?.value
          : null;
      final movies = await _searchMovies(
        query: event.query,
        type:  typeParam,
        year:  event.year,
        page:  event.page,
      );
      emit(MovieSearchLoaded(movies));
    } catch (e) {
      emit(MovieSearchError(e.toString()));
    }
  }
}
