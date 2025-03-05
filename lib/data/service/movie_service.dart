import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:dio/dio.dart';

class MovieService {
  final Dio _dio;
  MovieService(this._dio);
  Future<Movie> getPopularMovies() async {
    try {
      final response = await _dio.get('/movie/popular', queryParameters: {
        'language': 'tr-TR',
        'page': 1,
      });
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorPopularMovies}: $e');
    }
  }

  Future<Movie> getTrendingMovies() async {
    try {
      final response = await _dio.get('/trending/movie/day', queryParameters: {
        'language': 'tr-TR',
        'page': 1,
      });
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorTrendingMovies} : $e');
    }
  }

  Future<Movie> getTopRatedMovies() async {
    try {
      final response = await _dio.get('/movie/top_rated', queryParameters: {
        'language': 'tr-TR',
        'page': 1,
      });
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorTopRatedMovies} $e');
    }
  }

  Future<Movie> getMoviesByGenres(int genreIds) async {
    try {
      final response = await _dio.get('/discover/movie', queryParameters: {
        'with_genres': genreIds,
        'language': 'tr-TR',
        'page': 1,
      });
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorMoviesByGenres}: $e');
    }
  }
}
