import 'package:cinemate_app/data/model/favorite_model.dart';
import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final List<FavoriteItem>? favorites;
  final List<FavoriteItem>? movieFavorites;
  final List<FavoriteItem>? tvFavorites;
  final bool isLoading;
  final bool isFavoriteLoading;
  final String? errorMessage;
  final int? favoriteCount;
  final int? movieFavoriteCount;
  final int? tvFavoriteCount;
  final DateTime? lastUpdated;

  FavoriteState({
    this.favorites,
    this.movieFavorites,
    this.tvFavorites,
    this.isLoading = false,
    this.isFavoriteLoading = false,
    this.errorMessage,
    this.favoriteCount,
    this.movieFavoriteCount,
    this.tvFavoriteCount,
    this.lastUpdated,
  });

  FavoriteState copyWith({
    List<FavoriteItem>? favorites,
    List<FavoriteItem>? movieFavorites,
    List<FavoriteItem>? tvFavorites,
    bool? isLoading,
    bool? isFavoriteLoading,
    String? errorMessage,
    int? favoriteCount,
    int? movieFavoriteCount,
    int? tvFavoriteCount,
    DateTime? lastUpdated,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      movieFavorites: movieFavorites ?? this.movieFavorites,
      tvFavorites: tvFavorites ?? this.tvFavorites,
      isLoading: isLoading ?? this.isLoading,
      isFavoriteLoading: isFavoriteLoading ?? this.isFavoriteLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      movieFavoriteCount: movieFavoriteCount ?? this.movieFavoriteCount,
      tvFavoriteCount: tvFavoriteCount ?? this.tvFavoriteCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  factory FavoriteState.initial() {
    return FavoriteState(
      favorites: [],
      movieFavorites: [],
      tvFavorites: [],
      isLoading: false,
      isFavoriteLoading: false,
      favoriteCount: 0,
      movieFavoriteCount: 0,
      tvFavoriteCount: 0,
    );
  }
  @override
  List<Object?> get props => [
        favorites,
        movieFavorites,
        tvFavorites,
        isLoading,
        isFavoriteLoading,
        errorMessage,
        favoriteCount,
        movieFavoriteCount,
        tvFavoriteCount,
        lastUpdated,
      ];
}
