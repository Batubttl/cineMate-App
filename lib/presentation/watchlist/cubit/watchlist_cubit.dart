import 'package:cinemate_app/core/enum/media_type.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/presentation/watchlist/cubit/watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(WatchlistState.initial());

  Future<void> toggleWatchlist({
    required MovieResults item,
    required MediaType mediaType,
  }) async {
    try {
      emit(state.copyWith(isLoading: true));

      final isInWatchlist = state.watchlist.any((movie) => movie.id == item.id);

      if (isInWatchlist) {
        // Remove from watchlist
        final updatedWatchlist =
            state.watchlist.where((movie) => movie.id != item.id).toList();

        emit(state.copyWith(
          watchlist: updatedWatchlist,
          isLoading: false,
        ));
      } else {
        // Add to watchlist
        final updatedWatchlist = [...state.watchlist, item];

        emit(state.copyWith(
          watchlist: updatedWatchlist,
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      ));
    }
  }

  bool isInWatchlist(int movieId) {
    return state.watchlist.any((movie) => movie.id == movieId);
  }
}
