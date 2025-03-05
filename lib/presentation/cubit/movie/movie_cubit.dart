import 'package:cinemate_app/data/service/movie_service.dart';
import 'package:cinemate_app/presentation/cubit/movie/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieService _movieService;
  MovieCubit(this._movieService) : super(MovieState.initial());

  Future<void> getTrendingMovies() async {
    emit(state.copyWith(isLoading: true));

    try {
      final movie = await _movieService.getTrendingMovies();
      emit(state.copyWith(trendingMovies: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> getPopularMovies() async {
    emit(state.copyWith(isLoading: true));

    try {
      final movie = await _movieService.getPopularMovies();

      emit(state.copyWith(popularMovies: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> getTopRatedMovies() async {
    emit(state.copyWith(isLoading: true));
    try {
      final movie = await _movieService.getTopRatedMovies();
      emit(state.copyWith(topRatedMovies: movie.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
