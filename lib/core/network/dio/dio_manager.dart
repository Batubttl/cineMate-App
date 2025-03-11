import 'package:cinemate_app/core/constant/api_constant.dart';
import 'package:dio/dio.dart';

class DioManager {
  static final instance = DioManager._();
  late final Dio dio;

  DioManager._() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        queryParameters: {
          'api_key': ApiConstant.apiKey,
        },
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }
}
