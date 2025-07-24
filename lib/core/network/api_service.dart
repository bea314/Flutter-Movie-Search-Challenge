import 'package:dio/dio.dart';

/// A thin wrapper around Dio that centralizes JSON (and binary) requests
/// and uniform error handling.
class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  /// Performs a GET and returns the decoded JSON as a Map.
  /// Throws an [Exception] if the request fails.
  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Performs a GET and returns the raw bytes (for images).
  Future<List<int>> getBytes(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final resp = await _dio.get<List<int>>(
        path,
        queryParameters: queryParameters,
        options: options?.copyWith(responseType: ResponseType.bytes) ??
            Options(responseType: ResponseType.bytes),
      );
      return resp.data ?? <int>[];
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// (Optional) Other methods: postJson, putJson, deleteJson, etc.

  void _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        throw Exception('Connection error: ${error.message}');
      case DioExceptionType.sendTimeout:
        throw Exception('Send timeout: ${error.message}');
      case DioExceptionType.receiveTimeout:
        throw Exception('Receive timeout: ${error.message}');
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        final data = error.response?.data;
        throw Exception('Server error [$status]: $data');
      default:
        throw Exception('Unexpected error: ${error.message}');
    }
  }
}
