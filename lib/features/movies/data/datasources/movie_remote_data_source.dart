import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';

abstract class MovieRemoteDataSource {
  /// Hits OMDb’s “detail” endpoint and returns a single MovieDetailModel.
  Future<MovieDetailModel> getMovieDetailApi(String id);
  /// Hits OMDb’s “search” endpoint and returns a list of MovieModel.
  Future<List<MovieModel>> searchMoviesApi({
    required String query,
    String? type,
    String? year,
    int page,
  });

}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio _dio = ApiClient().dataDio;

  @override
  Future<MovieDetailModel> getMovieDetailApi(String id) async {
    final resp = await _dio.get(
      '/',
      queryParameters: {'i': id,},
    );
    if (resp.statusCode == 200) {
      return MovieDetailModel.fromMap(resp.data as Map<String, dynamic>);
    }
    throw Exception('Server error: ${resp.statusCode}');
  }

  @override
  Future<List<MovieModel>> searchMoviesApi({
    required String query,
    String? type,
    String? year,
    int page = 1,
  }) async {
    final resp = await _dio.get(
      '/',
      queryParameters: {
        's': query,
        'page': page.toString(),
        if (type != null) 'type': type,
        if (year != null) 'y': year,
      },
    );
    if (resp.statusCode == 200 && resp.data['Search'] != null) {
      final list = resp.data['Search'] as List<dynamic>;
      return list
          .map((e) => MovieModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error searching movies: ${resp.statusCode}');
  }
}
