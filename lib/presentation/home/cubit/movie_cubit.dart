import 'dart:async';
import 'package:cinemate_app/core/enum/movie_list_type.dart';
import 'package:cinemate_app/data/model/genre_model.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/data/service/movie_service.dart';
import 'package:cinemate_app/presentation/home/cubit/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieService _movieService;

  MovieCubit({required MovieService movieService})
      : _movieService = movieService,
        super(MovieState(isLoading: false));
  Future<void> loadHomePageData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final trendingMovie = await _movieService.getTrendingMovies();
      final popularMovie = await _movieService.getPopularMovies();
      final topRatedMovie = await _movieService.getTopRatedMovies();
      final genres = await _movieService.getGenres();

      // Genrelere göre filmleri yükle
      final Map<int, List<MovieResults>> moviesByGenre = {};

      await Future.wait(
        genres.map((GenreModel genre) async {
          final Movie movies = await _movieService.getMoviesByGenre(genre.id);
          moviesByGenre[genre.id] = movies.results;
        }),
      );

      emit(
        state.copyWith(
          trendingMovies: trendingMovie.results,
          popularMovies: popularMovie.results,
          topRatedMovies: topRatedMovie.results,
          genres: genres,
          moviesByGenre: moviesByGenre,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> getTrendingMovies() async {
    emit(state.copyWith(isLoading: true));
    try {
      final Movie movie = await _movieService.getTrendingMovies();
      emit(state.copyWith(trendingMovies: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> getPopularMovies() async {
    emit(state.copyWith(isLoading: true));
    try {
      final Movie movie = await _movieService.getPopularMovies();
      emit(state.copyWith(popularMovies: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> getTopRatedMovies() async {
    emit(state.copyWith(isLoading: true));
    try {
      final Movie movie = await _movieService.getTopRatedMovies();
      emit(state.copyWith(topRatedMovies: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> loadGenresWithMovie() async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<GenreModel> genres = await _movieService.getGenres();
      final Map<int, List<MovieResults>> moviesByGenre = {};

      await Future.wait(
        genres.map((GenreModel genre) async {
          final Movie movies = await _movieService.getMoviesByGenre(genre.id);
          moviesByGenre[genre.id] = movies.results;
        }),
      );

      emit(
        state.copyWith(
          genres: genres,
          moviesByGenre: moviesByGenre,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(searchResults: []));
      return;
    }

    emit(state.copyWith(isSearching: true));
    try {
      final List<MovieResults> results =
          await _movieService.searchMovies(query);
      emit(
        state.copyWith(
          searchResults: results,
          isSearching: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isSearching: false,
        ),
      );
    }
  }

  Future<void> loadMore(MovieListType type, {int? genreId}) async {
    if (state.isLoading) return;

    try {
      switch (type) {
        case MovieListType.popular:
          await _loadMorePopular();
        case MovieListType.trending:
          await _loadMoreTrending();
        case MovieListType.topRated:
          await _loadMoreTopRated();
        case MovieListType.byGenre:
          if (genreId != null) {
            await _loadMoreByGenre(genreId);
          }
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
          emit(state.copyWith(moviesByGenre: {}));
          await loadGenresWithMovie();
        }
    }
  }

  Future<void> _loadMorePopular() async {
    if (!state.hasMorePopularMovies) return;

    final nextPage = (state.popularMovies?.length ?? 0) ~/ 20 + 1;
    final movie = await _movieService.getPopularMovies(page: nextPage);

    final List<MovieResults> updatedMovies = [
      ...(state.popularMovies ?? []),
      ...movie.results,
    ];

    emit(
      state.copyWith(
        popularMovies: updatedMovies,
        hasMorePopularMovies: movie.page < movie.totalPages,
      ),
    );
  }

  Future<void> _loadMoreTrending() async {
    if (!state.hasMoreTrendingMovies) return;

    final nextPage = (state.trendingMovies?.length ?? 0) ~/ 20 + 1;
    final movie = await _movieService.getTrendingMovies(page: nextPage);

    final List<MovieResults> updatedMovies = [
      ...(state.trendingMovies ?? []),
      ...movie.results,
    ];

    emit(
      state.copyWith(
        trendingMovies: updatedMovies,
        hasMoreTrendingMovies: movie.page < movie.totalPages,
      ),
    );
  }

  Future<void> _loadMoreTopRated() async {
    if (!state.hasMoreTopRatedMovies) return;

    final nextPage = (state.topRatedMovies?.length ?? 0) ~/ 20 + 1;
    final movie = await _movieService.getTopRatedMovies(page: nextPage);

    final List<MovieResults> updatedMovies = [
      ...(state.topRatedMovies ?? []),
      ...movie.results,
    ];

    emit(
      state.copyWith(
        topRatedMovies: updatedMovies,
        hasMoreTopRatedMovies: movie.page < movie.totalPages,
      ),
    );
  }

  Future<void> _loadMoreByGenre(int genreId) async {
    if (!state.hasMoreMoviesByGenre) return;

    final currentMovies = state.moviesByGenre![genreId] ?? [];
    final nextPage = currentMovies.length ~/ 20 + 1;

    final movie = await _movieService.getMoviesByGenre(genreId, page: nextPage);

    final List<MovieResults> updatedMovies = [
      ...currentMovies,
      ...movie.results,
    ];

    final updatedMoviesByGenre = Map<int, List<MovieResults>>.from(
      state.moviesByGenre ?? {},
    );
    updatedMoviesByGenre[genreId] = updatedMovies;

    emit(
      state.copyWith(
        moviesByGenre: updatedMoviesByGenre,
        hasMoreMoviesByGenre: movie.page < movie.totalPages,
      ),
    );
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
  void clearSearchResults() => emit(state.copyWith(searchResults: []));
  void clearSelectedMovie() => emit(state.copyWith(selectedMovie: null));
}
