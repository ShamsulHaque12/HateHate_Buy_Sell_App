import 'package:dio/dio.dart';
import '../constants/api_urls.dart';
import '../error/exceptions.dart';
import 'api_interceptor.dart';

class DioClient {
  final Dio _dio;

  DioClient({Dio? dio}) : _dio = dio ?? Dio() {
    _dio
      ..options.baseUrl = ApiUrls.baseUrl
      ..options.connectTimeout = ApiUrls.connectTimeout
      ..options.receiveTimeout = ApiUrls.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(ApiInterceptor());
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException(message: 'Connection timed out or failed.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message']?.toString() ??
            error.message ??
            'Server responded with status $statusCode';
        if (statusCode == 401) {
          return UnauthorizedException(message: message);
        }
        return ServerException(message: message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const ServerException(message: 'Request was cancelled.');
      default:
        return ServerException(
          message: error.message ?? 'Unexpected network error occurred.',
        );
    }
  }
}
