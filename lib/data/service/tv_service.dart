import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/network/dio_manager.dart';

class TvService {
  final dio = DioManager.instance.dio;

  Future<Map<String, dynamic>> getPopularTv() async {
    try {
      final response = await dio.get('/tv/popular');
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorPopularTvShows}: $e');
    }
  }

  Future<Map<String, dynamic>> getTrendingTv() async {
    try {
      final response = await dio.get('/trending/tv/day');
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorTrendingTvShows}: $e');
    }
  }

  Future<Map<String, dynamic>> getTopRatedTv() async {
    try {
      final response = await dio.get('/tv/top_rated');
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorTopRatedTvShows}: $e');
    }
  }
}
