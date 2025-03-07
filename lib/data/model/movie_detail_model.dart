import 'package:cinemate_app/data/model/genre_model.dart';
import 'package:cinemate_app/data/model/movie_model.dart';

class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final int runtime;
  final List<GenreModel> genres;
  final List<Cast> cast;
  final List<MovieResults> similarMovies;
  final List<MovieResults> recommendations;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
    required this.cast,
    required this.similarMovies,
    required this.recommendations,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => GenreModel.fromJson(e))
              .toList() ??
          [],
      cast: (json['credits']?['cast'] as List<dynamic>?)
              ?.map((e) => Cast.fromJson(e))
              .toList() ??
          [],
      similarMovies: (json['similar']?['results'] as List<dynamic>?)
              ?.map((e) => MovieResults.fromJson(e))
              .toList() ??
          [],
      recommendations: (json['recommendations']?['results'] as List<dynamic>?)
              ?.map((e) => MovieResults.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Cast {
  final int id;
  final String name;
  final String? profilePath;
  final String character;

  Cast({
    required this.id,
    required this.name,
    this.profilePath,
    required this.character,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profilePath: json['profile_path'],
      character: json['character'] ?? '',
    );
  }
}
