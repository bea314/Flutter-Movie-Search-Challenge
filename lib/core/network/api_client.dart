import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;

import '../config/api_config.dart';

class ApiClient {
  // Singleton
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dataDio;
  late final Dio imageDio;

  factory ApiClient() => _instance;

  ApiClient._internal() {
    final commonOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
      queryParameters: {'apikey': dotenv.env['OMDB_API_KEY']},
    );

    dataDio = Dio(commonOptions.copyWith(baseUrl: ApiConfig.baseUrl));
    imageDio = Dio(commonOptions.copyWith(baseUrl: ApiConfig.posterBaseUrl));

    dataDio.interceptors.add(LogInterceptor());
    imageDio.interceptors.add(LogInterceptor());
  }
}

