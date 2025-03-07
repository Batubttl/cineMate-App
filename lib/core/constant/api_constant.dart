import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String movieDetail = '/movie';

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String originalImage = '$imageBaseUrl/original';
  static const String w500Image = '$imageBaseUrl/w500';
  static const String _moviePath = '/movie';
  static const String _accountPath = '/account';
  static const String _genrePath = '/genre';
  static const String _searchPath = '/search';
  static const String _trendingPath = '/trending';

  // Movie Endpoints
  static const String popularPath = '$_moviePath/popular';
  static const String topRatedPath = '$_moviePath/top_rated';
  static const String upcomingPath = '$_moviePath/upcoming';
  static const String trendingPath = '$_trendingPath/movie/day';

  // Account Endpoints
  static const String favoriteMoviesPath =
      '$_accountPath/{account_id}/favorite/movies';
  static const String favoriteTvPath = '$_accountPath/{account_id}/favorite/tv';
  static const String addFavoritePath = '$_accountPath/{account_id}/favorite';

  // Genre Endpoints
  static const String movieGenresPath = '$_genrePath/movie/list';
  static const String tvGenresPath = '$_genrePath/tv/list';
}
