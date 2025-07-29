import '../../data/models/movie_detail_model.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel detail;
  MovieDetailLoaded(this.detail);
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);
}
