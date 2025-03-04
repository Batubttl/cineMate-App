import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/network/dio/dio_manager.dart';
import 'package:dio/dio.dart';

class TVService {
  final Dio dio;
  TVService(this.dio);
  Future<Map<String, dynamic>> getPopularTvShows() async {
    try {
      final response = await dio.get('/tv/popular', queryParameters: {
        'language': 'tr-TR',
        'page': 1,
      });
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorPopularTvShows}: $e');
    }
  }

  Future<Map<String, dynamic>> getTrendingTvShows() async {
    try {
      final response = await dio.get('/trending/tv/day', queryParameters: {
        'language': 'tr-TR',
        'page': 1,
      });
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorTrendingTvShows}: $e');
    }
  }

  Future<Map<String, dynamic>> getTopRatedTvShows() async {
    try {
      final response = await dio.get('/tv/top_rated', queryParameters: {
        'language': 'tr-TR',
        'page': 1,
      });
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorTopRatedTvShows}: $e');
    }
  }
}
