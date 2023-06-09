import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:test_tecnico/src/utils/methods.dart';

class NetworkManager {
  factory NetworkManager() {
    final dio = Dio();

    final interceptor = DioCacheManager(
      CacheConfig(
        defaultMaxAge: const Duration(days: 10),
        maxMemoryCacheCount: 50,
      ),
    ).interceptor as Interceptor;

    dio.interceptors.add(interceptor);

    return NetworkManager._(dio);
  }

  const NetworkManager._(this.dio);
  final Dio dio;

  Future<Response<T>> request<T>(
    RequestMethod method,
    String url, {
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.request(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        method: method.value,
        headers: headers,
      ),
    );
  }
}

enum RequestMethod {
  get,
  head,
  post,
  put,
  delete,
  connect,
  options,
  trace,
  patch,
}

extension RequestMethodX on RequestMethod {
  String get value => getEnumValue(this).toUpperCase();
}
