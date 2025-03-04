import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/network/dio_manager.dart';
import 'package:dio/dio.dart';

class MovieService {
  final Dio _dio = DioManager.instance.dio;

  // Popüler filmleri getir
  Future<Map<String, dynamic>> getPopularMovies() async {
    try {
      final response = await _dio.get('/movie/popular');
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorPopularMovies}: $e');
    }
  }

  Future<Map<String, dynamic>> getTrendingMovies() async {
    try {
      final response = await _dio.get('/trending/movie/day');
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorTrendingMovies} : $e');
    }
  }

  Future<Map<String, dynamic>> getTopRatedMovies() async {
    try {
      final response = await _dio.get('/movie/top_rated');
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorTopRatedMovies} $e');
    }
  }

  Future<Map<String, dynamic>> getMoviesByGenres(int genreIds) async {
    try {
      final response = await _dio.get('/discover/movie', queryParameters: {
        'with_genres': genreIds,
      });
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorMoviesByGenres}: $e');
    }
  }
}
