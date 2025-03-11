import 'package:cinemate_app/core/constant/api_constant.dart';
import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/extension/api_path_extension.dart';
import 'package:cinemate_app/data/model/favorite_model.dart';
import 'package:cinemate_app/data/model/genre_model.dart';
import 'package:cinemate_app/data/model/movie_detail_model.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:dio/dio.dart';

class MovieService {
  final Dio _dio;

  MovieService(this._dio);

  // Popular Movies
  Future<Movie> getPopularMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        ApiConstant.popularPath,
        queryParameters: {
          'language': 'tr-TR',
          'page': page,
        },
      );
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorPopularMovies}: $e');
    }
  }

  // Trending Movies
  Future<Movie> getTrendingMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        ApiConstant.trendingPath,
        queryParameters: {
          'language': 'tr-TR',
          'page': page,
        },
      );
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorTrendingMovies}: $e');
    }
  }

  // Top Rated Movies
  Future<Movie> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        ApiConstant.topRatedPath,
        queryParameters: {
          'language': 'tr-TR',
          'page': page,
        },
      );
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorTopRatedMovies}: $e');
    }
  }

  // Movie Detail
  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final response = await _dio.get(
        ApiConstant.movieDetailPath.withMovieId(movieId),
        queryParameters: {
          'language': 'tr-TR',
          'append_to_response': 'videos,credits,similar,recommendations',
        },
      );
      return MovieDetail.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorMovieDetail}: $e');
    }
  }

  // Genres
  Future<List<GenreModel>> getGenres() async {
    try {
      final response = await _dio.get(
        ApiConstant.movieGenresPath,
        queryParameters: {
          'language': 'tr-TR',
        },
      );

      final genreResponse = GenreResponse.fromJson(response.data);
      return genreResponse.genres;
    } catch (e) {
      throw Exception('${AppString.errorGenres}: $e');
    }
  }

  // Movies by Genre
  Future<Movie> getMoviesByGenre(int genreId, {int page = 1}) async {
    try {
      final response = await _dio.get(
        ApiConstant.discoverMoviePath.withGenreId(genreId),
        queryParameters: {
          'language': 'tr-TR',
          'page': page,
          'sort_by': 'popularity.desc',
        },
      );
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorMoviesByGenres}: $e');
    }
  }

  // Search Movies
  Future<Movie> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await _dio.get(
        ApiConstant.searchMoviePath,
        queryParameters: {
          'query': query,
          'language': 'tr-TR',
          'page': page,
          'include_adult': false,
        },
      );
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('${AppString.errorSearch}: $e');
    }
  }
}
