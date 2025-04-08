import 'package:cinemate_app/data/service/movie_detail_service.dart';
import 'package:cinemate_app/presentation/detail/cubit/detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCubit extends Cubit<DetailState> {
  final MovieDetailService _movieDetailService;

  DetailCubit(this._movieDetailService) : super(const DetailState());

  Future<void> fetchMovieDetail(int movieId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final movieDetail = await _movieDetailService.getMovieDetail(movieId);
      emit(
        state.copyWith(
          movieDetail: movieDetail,
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
}
