import 'package:cinemate_app/core/network/dio/dio_manager.dart';
import 'package:dio/dio.dart';

class PersonService {
  final Dio _dio = DioManager.instance.dio;

  Future<Map<String, dynamic>> getPopularPersons() async {
    try {
      final response = await _dio.get('/person/popular');
      return response.data;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
