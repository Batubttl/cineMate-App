import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieState extends Equatable {
  final List<MovieResults>? popularMovies;
  final List<MovieResults>? trendingMovies;
  final List<MovieResults>? topRatedMovies;
  final List<MovieResults>? moviesByGenre;
  final bool isLoading;
  final String? errorMessage;

  const MovieState({
    required this.popularMovies,
    required this.trendingMovies,
    required this.topRatedMovies,
    required this.moviesByGenre,
    required this.isLoading,
    this.errorMessage,
  });

  factory MovieState.initial() => const MovieState(
        popularMovies: [],
        trendingMovies: [],
        topRatedMovies: [],
        moviesByGenre: [],
        isLoading: false,
      );
  MovieState copyWith({
    List<MovieResults>? popularMovies,
    List<MovieResults>? trendingMovies,
    List<MovieResults>? topRatedMovies,
    List<MovieResults>? moviesByGenre,
    bool? isLoading,
    String? errorMessage,
  }) =>
      MovieState(
          popularMovies: popularMovies ?? this.popularMovies,
          trendingMovies: trendingMovies ?? this.trendingMovies,
          topRatedMovies: topRatedMovies ?? this.topRatedMovies,
          moviesByGenre: moviesByGenre ?? this.moviesByGenre,
          isLoading: isLoading ?? this.isLoading,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object?> get props => [
        popularMovies,
        trendingMovies,
        topRatedMovies,
        moviesByGenre,
        isLoading,
        errorMessage,
      ];
}
