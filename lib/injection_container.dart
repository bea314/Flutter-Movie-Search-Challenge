import 'package:get_it/get_it.dart';
import 'core/network/api_client.dart';
import 'core/network/api_service.dart';

import 'features/movies/data/datasources/movie_remote_data_source.dart';
import 'features/movies/data/repositories/movie_repository_impl.dart';
import 'features/movies/logic/repositories/movie_repository.dart';
import 'features/movies/logic/usecases/get_movie_detail.dart';
import 'features/movies/views/bloc/movie_detail_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<ApiClient>().dataDio),);

  // Data layer
  sl.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(),);
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl<MovieRemoteDataSource>()),);

  // Use cases
  // sl.registerLazySingleton(() => SearchMovies(sl<MovieRepository>()));
  sl.registerLazySingleton(() => GetMovieDetail(sl<MovieRepository>()));

  // Presentation – BLoCs
  // sl.registerFactory(() => MovieSearchBloc(sl<SearchMovies>()));
  sl.registerFactory(() => MovieDetailBloc(sl<GetMovieDetail>()));
}
