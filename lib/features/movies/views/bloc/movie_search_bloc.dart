
import 'package:flutter_bloc/flutter_bloc.dart';

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
      final movies = await _searchMovies(event.query);
      emit(MovieSearchLoaded(movies));
    } catch (e) {
      emit(MovieSearchError(e.toString()));
    }
  }
}
