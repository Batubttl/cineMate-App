class Movie {
  final int page;
  final List<MovieResults> results;
  final int totalPages;
  final int totalResult;

  Movie({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResult,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MovieResults.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResult: json['total_results'] ?? 0,
    );
  }

  // Movie nesnesinden JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResult,
    };
  }
}

class MovieResults {
  final bool adult;
  final String? backdropPath; // null olabilir
  final List<int>? genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath; // null olabilir
  final String? releaseDate;
  final String title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieResults({
    required this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  // JSON'dan MovieResults nesnesine dönüştürme
  factory MovieResults.fromJson(Map<String, dynamic> json) {
    return MovieResults(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'], // null olabilir
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] ?? 0,
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      posterPath: json['poster_path'], // null olabilir
      releaseDate: json['release_date'],
      title: json['title'] ?? '',
      video: json['video'],
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'],
    );
  }

  // MovieResults nesnesinden JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
