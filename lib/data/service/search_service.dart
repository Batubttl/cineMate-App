import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/network/dio_manager.dart';
import 'package:dio/dio.dart';

class SearchService {
  final Dio _dio = DioManager.instance.dio;

  Future<Map<String, dynamic>> search(String query) async {
    try {
      final response = await _dio.get(
        '/search/multi',
        queryParameters: {
          'query': query,
          'include_adult': true,
          'language': 'tr-TR',
          'page': 1,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('${AppString.errorSearch}: $e');
    }
  }
}
