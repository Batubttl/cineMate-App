import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/network/dio/dio_manager.dart';
import 'package:dio/dio.dart';

class PersonService {
  final Dio _dio;
  PersonService(this._dio);

  /// Popüler kişileri getirir
  Future<Map<String, dynamic>> getPopularPeople() async {
    try {
      final response = await _dio.get(
        '/person/popular',
        queryParameters: {
          'language': 'tr-TR',
          'page': 1,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('${AppString.errorPopularPeople}: ${e.message}');
    }
  }
}
