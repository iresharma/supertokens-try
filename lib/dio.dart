import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:supertokens/dio.dart';

Dio setupDio(String url) {
  Dio dio = Dio(BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 5000,
    baseUrl: url,
  ));
  dio.interceptors.add(SuperTokensInterceptorWrapper(client: dio));
  dio.interceptors.add(HttpFormatter());
  return dio;
}
