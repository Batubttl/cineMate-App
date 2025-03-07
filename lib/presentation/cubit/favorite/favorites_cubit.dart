// Cubit sınıfı
import 'package:cinemate_app/core/enum/media_type.dart';
import 'package:cinemate_app/data/model/favorite_model.dart';
import 'package:cinemate_app/data/service/local_favorite_service.dart';
import 'package:cinemate_app/presentation/cubit/favorite/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final LocalFavoriteService _localFavoriteService;

  FavoriteCubit(this._localFavoriteService) : super(FavoriteState.initial()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      emit(state.copyWith(isLoading: true));

      final favorites = await _localFavoriteService.getFavorites();
      final movieFavorites =
          await _localFavoriteService.getFavoritesByType(MediaType.movie);
      final tvFavorites =
          await _localFavoriteService.getFavoritesByType(MediaType.tv);

      final favoriteCount = await _localFavoriteService.getFavoriteCount();
      final movieFavoriteCount =
          await _localFavoriteService.getFavoriteCount(type: MediaType.movie);
      final tvFavoriteCount =
          await _localFavoriteService.getFavoriteCount(type: MediaType.tv);

      final lastUpdated = _localFavoriteService.getLastUpdated();

      emit(
        state.copyWith(
          favorites: favorites,
          movieFavorites: movieFavorites,
          tvFavorites: tvFavorites,
          favoriteCount: favoriteCount,
          movieFavoriteCount: movieFavoriteCount,
          tvFavoriteCount: tvFavoriteCount,
          lastUpdated: lastUpdated,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  Future<void> toggleFavorite({
    required dynamic item,
    required MediaType mediaType,
  }) async {
    try {
      emit(state.copyWith(isFavoriteLoading: true));

      final isFavorite = await _localFavoriteService.isFavorite(
        item.id,
        mediaType,
      );

      if (isFavorite) {
        await _localFavoriteService.removeFavorite(item.id, mediaType);
      } else {
        final favoriteItem = FavoriteItem(
          id: item.id,
          title: mediaType == MediaType.movie ? item.title : item.name,
          posterPath: item.posterPath,
          backdropPath: item.backdropPath,
          voteAverage: item.voteAverage,
          mediaType: mediaType.value,
        );
        await _localFavoriteService.addFavorite(favoriteItem);
      }

      await loadFavorites();
      emit(state.copyWith(isFavoriteLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isFavoriteLoading: false,
        ),
      );
    }
  }

  Future<bool> checkIsFavorite(int id, MediaType mediaType) async {
    try {
      return await _localFavoriteService.isFavorite(id, mediaType);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      return false;
    }
  }

  Future<void> clearAllFavorites() async {
    try {
      emit(state.copyWith(isLoading: true));
      await _localFavoriteService.clearFavorites();
      await loadFavorites();
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  Future<void> clearFavoritesByType(MediaType type) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _localFavoriteService.clearFavoritesByType(type);
      await loadFavorites();
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
