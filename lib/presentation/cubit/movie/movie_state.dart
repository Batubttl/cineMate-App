import 'package:cinemate_app/data/model/favorite_model.dart';
import 'package:cinemate_app/data/model/movie_detail_model.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieState extends Equatable {
  final List<MovieResults>? popularMovies;
  final List<MovieResults>? trendingMovies;
  final List<MovieResults>? topRatedMovies;
  final List<MovieResults>? moviesByGenre;
  final List<MovieResults>? searchResults;
  final List<FavoriteItem>? favorites;

  final MovieDetail? selectedMovie;
  final bool isFavorite;

  final bool isLoading;
  final bool isSearching;

  final bool hasMorePopularMovies;
  final bool hasMoreTrendingMovies;
  final bool hasMoreTopRatedMovies;
  final bool hasMoreMoviesByGenre;

  final String? errorMessage;

  const MovieState({
    this.favorites,
    this.isFavorite = false,
    this.popularMovies,
    this.trendingMovies,
    this.topRatedMovies,
    this.moviesByGenre,
    this.searchResults,
    this.selectedMovie,
    required this.isLoading,
    this.isSearching = false,
    this.hasMorePopularMovies = true,
    this.hasMoreTrendingMovies = true,
    this.hasMoreTopRatedMovies = true,
    this.hasMoreMoviesByGenre = true,
    this.errorMessage,
  });

  factory MovieState.initial() => const MovieState(
      popularMovies: [],
      trendingMovies: [],
      topRatedMovies: [],
      moviesByGenre: [],
      searchResults: [],
      isLoading: false,
      favorites: []);

  MovieState copyWith({
    List<MovieResults>? popularMovies,
    List<MovieResults>? trendingMovies,
    List<MovieResults>? topRatedMovies,
    List<MovieResults>? moviesByGenre,
    List<MovieResults>? searchResults,
    List<FavoriteItem>? favorites,
    MovieDetail? selectedMovie,
    bool? isLoading,
    bool? isSearching,
    bool? isFavorite,
    bool? hasMorePopularMovies,
    bool? hasMoreTrendingMovies,
    bool? hasMoreTopRatedMovies,
    bool? hasMoreMoviesByGenre,
    String? errorMessage,
  }) =>
      MovieState(
        popularMovies: popularMovies ?? this.popularMovies,
        trendingMovies: trendingMovies ?? this.trendingMovies,
        topRatedMovies: topRatedMovies ?? this.topRatedMovies,
        moviesByGenre: moviesByGenre ?? this.moviesByGenre,
        searchResults: searchResults ?? this.searchResults,
        selectedMovie: selectedMovie ?? this.selectedMovie,
        isLoading: isLoading ?? this.isLoading,
        isSearching: isSearching ?? this.isSearching,
        isFavorite: isFavorite ?? this.isFavorite,
        favorites: favorites,
        hasMorePopularMovies: hasMorePopularMovies ?? this.hasMorePopularMovies,
        hasMoreTrendingMovies:
            hasMoreTrendingMovies ?? this.hasMoreTrendingMovies,
        hasMoreTopRatedMovies:
            hasMoreTopRatedMovies ?? this.hasMoreTopRatedMovies,
        hasMoreMoviesByGenre: hasMoreMoviesByGenre ?? this.hasMoreMoviesByGenre,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        popularMovies,
        trendingMovies,
        topRatedMovies,
        moviesByGenre,
        searchResults,
        selectedMovie,
        favorites,
        isFavorite,
        isLoading,
        isSearching,
        hasMorePopularMovies,
        hasMoreTrendingMovies,
        hasMoreTopRatedMovies,
        hasMoreMoviesByGenre,
        errorMessage,
      ];
}
