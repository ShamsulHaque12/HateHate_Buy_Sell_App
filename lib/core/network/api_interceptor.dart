import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add default headers
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    // Example token handling - replace with actual token retrieval from secure storage
    // if (token != null) options.headers['Authorization'] = 'Bearer $token';

    if (kDebugMode) {
      debugPrint('[DIO REQUEST] ${options.method} => ${options.uri}');
      debugPrint('[DIO HEADERS] ${options.headers}');
      if (options.data != null) {
        debugPrint('[DIO DATA] ${options.data}');
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('[DIO RESPONSE] ${response.statusCode} <= ${response.requestOptions.uri}');
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('[DIO ERROR] ${err.response?.statusCode} <= ${err.requestOptions.uri}');
      debugPrint('[DIO ERROR MESSAGE] ${err.message}');
    }
    return handler.next(err);
  }
}
