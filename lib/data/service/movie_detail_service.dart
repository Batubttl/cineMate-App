import 'package:cinemate_app/core/constant/api_constant.dart';
import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/extension/api_path_extension.dart';
import 'package:cinemate_app/data/model/movie_detail_model.dart';
import 'package:dio/dio.dart';

class MovieDetailService {
  final Dio _dio;

  MovieDetailService(this._dio);

  Future<MovieDetail?> getMovieDetail(int movieId) async {
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
}
