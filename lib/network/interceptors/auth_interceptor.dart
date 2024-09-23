import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      String token = GetStorage().read('token');
      if (token.isNotEmpty) {
        options.headers.addAll({"Authorization": 'Bearer  $token'});
      }
    } catch (e) {}

    super.onRequest(options, handler);
  }
}
