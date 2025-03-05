import 'package:cinemate_app/core/enum/movie_list_type.dart';
import 'package:cinemate_app/data/service/movie_service.dart';
import 'package:cinemate_app/presentation/cubit/movie/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieService _movieService;
  MovieCubit(this._movieService) : super(MovieState.initial());

  // Trending Movies
  Future<void> getTrendingMovies() async {
    emit(state.copyWith(isLoading: true));
    try {
      final movie = await _movieService.getTrendingMovies();
      emit(state.copyWith(trendingMovies: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  // Popular Movies
  Future<void> getPopularMovies() async {
    emit(state.copyWith(isLoading: true));
    try {
      final movie = await _movieService.getPopularMovies();
      emit(state.copyWith(popularMovies: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  // Top Rated Movies
  Future<void> getTopRatedMovies() async {
    emit(state.copyWith(isLoading: true));
    try {
      final movie = await _movieService.getTopRatedMovies();
      emit(state.copyWith(topRatedMovies: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  // Movies by Genre
  Future<void> getMoviesByGenre(int genreId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final movie = await _movieService.getMoviesByGenres(genreId);
      emit(state.copyWith(moviesByGenre: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  // Movie Detail
  Future<void> getMovieDetail(int movieId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final movie = await _movieService.getMovieDetail(movieId);
      emit(state.copyWith(selectedMovie: movie, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  // Search Movies
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(searchResults: []));
      return;
    }

    emit(state.copyWith(isSearching: true));
    try {
      final movie = await _movieService.searchMovies(query);
      emit(state.copyWith(
        searchResults: movie.results,
        isSearching: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isSearching: false,
      ));
    }
  }

  // Load More (Pagination)
  Future<void> loadMore(MovieListType type, {int? genreId}) async {
    if (state.isLoading) return;

    try {
      switch (type) {
        case MovieListType.popular:
          if (!state.hasMorePopularMovies) return;
          final nextPage = (state.popularMovies?.length ?? 0) ~/ 20 + 1;
          final movie = await _movieService.getPopularMovies(page: nextPage);
          final updatedMovies = [
            ...state.popularMovies ?? [],
            ...movie.results
          ];
          emit(state.copyWith(
            popularMovies: updatedMovies,
            hasMorePopularMovies: movie.page < movie.totalPages,
          ));

        case MovieListType.trending:
          if (!state.hasMoreTrendingMovies) return;
          final nextPage = (state.trendingMovies?.length ?? 0) ~/ 20 + 1;
          final movie = await _movieService.getTrendingMovies(page: nextPage);
          final updatedMovies = [
            ...state.trendingMovies ?? [],
            ...movie.results
          ];
          emit(state.copyWith(
            trendingMovies: updatedMovies,
            hasMoreTrendingMovies: movie.page < movie.totalPages,
          ));

        case MovieListType.topRated:
          if (!state.hasMoreTopRatedMovies) return;
          final nextPage = (state.topRatedMovies?.length ?? 0) ~/ 20 + 1;
          final movie = await _movieService.getTopRatedMovies(page: nextPage);
          final updatedMovies = [
            ...state.topRatedMovies ?? [],
            ...movie.results
          ];
          emit(state.copyWith(
            topRatedMovies: updatedMovies,
            hasMoreTopRatedMovies: movie.page < movie.totalPages,
          ));

        case MovieListType.byGenre:
          if (!state.hasMoreMoviesByGenre || genreId == null) return;
          final nextPage = (state.moviesByGenre?.length ?? 0) ~/ 20 + 1;
          final movie =
              await _movieService.getMoviesByGenres(genreId, page: nextPage);
          final updatedMovies = [
            ...state.moviesByGenre ?? [],
            ...movie.results
          ];
          emit(state.copyWith(
            moviesByGenre: updatedMovies,
            hasMoreMoviesByGenre: movie.page < movie.totalPages,
          ));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> refreshMovies(MovieListType type, {int? genreId}) async {
    switch (type) {
      case MovieListType.trending:
        emit(state.copyWith(trendingMovies: []));
        await getTrendingMovies();
      case MovieListType.popular:
        emit(state.copyWith(popularMovies: []));
        await getPopularMovies();
      case MovieListType.topRated:
        emit(state.copyWith(topRatedMovies: []));
        await getTopRatedMovies();
      case MovieListType.byGenre:
        if (genreId != null) {
          emit(state.copyWith(moviesByGenre: []));
          await getMoviesByGenre(genreId);
        }
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  void clearSearchResults() {
    emit(state.copyWith(searchResults: []));
  }

  void clearSelectedMovie() {
    emit(state.copyWith(selectedMovie: null));
  }
}
