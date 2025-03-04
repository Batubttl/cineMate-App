class ApiConstant {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'YOUR_API_KEY';

  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String movieDetail = '/movie';

  // Image URLs
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String originalImage = '$imageBaseUrl/original';
  static const String w500Image = '$imageBaseUrl/w500';

  static String getPosterUrl(String? path) {
    if (path == null) return '';
    return '$w500Image$path';
  }

  static String getBackdropUrl(String? path) {
    if (path == null) return '';
    return '$originalImage$path';
  }
}
