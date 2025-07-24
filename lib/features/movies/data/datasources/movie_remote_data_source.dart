import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../models/movie_detail_model.dart';

abstract class MovieRemoteDataSource {
  Future<MovieDetailModel> getMovieDetailApi(String id);
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
}
