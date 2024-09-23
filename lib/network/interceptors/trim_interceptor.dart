import 'package:dio/dio.dart';

class TrimRequestInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Trim any string values in the request
    options.data = _trimStrings(options.data);

    return super.onRequest(options, handler);
  }

  dynamic _trimStrings(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data.map((key, value) {
        if (value is String) {
          return MapEntry(key, value.trim());
        } else {
          return MapEntry(key, _trimStrings(value));
        }
      });
    } else if (data is List<dynamic>) {
      return data.map((value) => _trimStrings(value)).toList();
    } else if (data is String) {
      return data.trim();
    } else {
      return data;
    }
  }
}