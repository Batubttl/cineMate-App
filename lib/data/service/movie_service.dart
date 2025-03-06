import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/data/model/favorite_model.dart';
import 'package:cinemate_app/data/model/genre_model.dart';
import 'package:cinemate_app/data/model/movie_detail_model.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:dio/dio.dart';

class MovieService {
  final Dio _dio;
  MovieService(this._dio);

  Future<Movie> getPopularMovies({int page = 1}) async {
    try {
      final response = await _dio.get('/movie/popular', queryParameters: {
        'language': 'tr-TR',
        'page': page,
      });
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception(
            '${AppString.errorPopularMovies} :{response.statusCode}');
      }
    } catch (e) {
      throw Exception('${AppString.errorPopularMovies}: $e');
    }
  }

  Future<Movie> getTrendingMovies({int page = 1}) async {
    try {
      final response = await _dio.get('/trending/movie/day', queryParameters: {
        'language': 'tr-TR',
        'page': page,
      });
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception(
            '${AppString.errorTrendingMovies} :{response.statusCode}');
      }
    } catch (e) {
      throw Exception('${AppString.errorTrendingMovies} : $e');
    }
  }

  Future<Movie> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await _dio.get('/movie/top_rated', queryParameters: {
        'language': 'tr-TR',
        'page': page,
      });
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception(
            '${AppString.errorTopRatedMovies} :{response.statusCode}');
      }
    } catch (e) {
      throw Exception('${AppString.errorTopRatedMovies} $e');
    }
  }

  Future<List<GenreModel>> getGenres() async {
    try {
      final response = await _dio.get('/genre/movie/list', queryParameters: {
        'language': 'tr-TR',
      });
      if (response.statusCode == 200) {
        final genreResponse = GenreResponse.fromJson(response.data);
        return genreResponse.genres;
      } else {
        throw Exception(
            '${AppString.errorMoviesByGenres}: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('${AppString.errorMoviesByGenres}: $e');
    }
  }

  Future<Movie> getMoviesByGenre(int genreId, {int page = 1}) async {
    try {
      final response = await _dio.get('/discover/movie', queryParameters: {
        'language': 'tr-TR',
        'with_genres': genreId,
        'page': page,
        'sort_by': 'popularity.desc',
      });

      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception(
            '${AppString.errorMoviesByGenres}: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('${AppString.errorMoviesByGenres}: $e');
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId', queryParameters: {
        'language': 'tr-TR',
        'append_to_response': 'videos,credits,similar,recommendations',
      });
      if (response.statusCode == 200) {
        return MovieDetail.fromJson(response.data);
      } else {
        throw Exception(
            '${AppString.errorMovieDetail}: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('${AppString.errorMovieDetail}: $e');
    }
  }

  Future<Movie> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await _dio.get('/search/movie', queryParameters: {
        'query': query,
        'language': 'tr-TR',
        'page': page,
        'include_adult': false,
      });
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception('${AppString.errorSearch}: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('${AppString.errorSearch}: $e');
    }
  }

  Future<List<FavoriteItem>> getFavorites() async {
    try {
      final movieResponse =
          await _dio.get('/account/{account_id}/favorite/movies');
      final movies = FavoriteResponse.fromJson(movieResponse.data);
      final tvResponse = await _dio.get('/account/{account_id}/favorite/tv');
      final tvShow = FavoriteResponse.fromJson(tvResponse.data);
      return [...movies.results, ...tvShow.results];
    } catch (e) {
      throw Exception('${AppString.errorFavorites}: $e');
    }
  }

  Future<void> toggleFavorite(
      {required int mediaId,
      required bool isFavorite,
      required String accountId}) async {
    try {
      final response = await _dio.post('/account/$accountId/favorite', data: {
        'media_type': 'movie',
        'media_id': mediaId,
        'favorite': isFavorite,
      });
      return response.data;
    } catch (e) {
      throw Exception('${AppString.errorToggleFavorite}: $e');
    }
  }

  Future<bool> checkIsFavorites(int mediaId) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((element) => element.id == mediaId);
    } catch (e) {
      throw Exception('${AppString.errorCheckIsFavorites}: $e');
    }
  }
}
