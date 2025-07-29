import '../../logic/entities/movie.dart';

abstract class MovieSearchState {}

/// Init state, before search
class MovieSearchInitial extends MovieSearchState {}

/// While loading results
class MovieSearchLoading extends MovieSearchState {}

/// When results ready
class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> movies;
  MovieSearchLoaded(this.movies);
}

/// Error in search
class MovieSearchError extends MovieSearchState {
  final String message;
  MovieSearchError(this.message);
}
