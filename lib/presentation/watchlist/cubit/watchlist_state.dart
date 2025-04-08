import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:equatable/equatable.dart';

class WatchlistState extends Equatable {
  final List<MovieResults>? movieWatchlist;
  final List<MovieResults>? tvWatchlist;
  final bool isLoading;
  final String? errorMessage;

  const WatchlistState({
    this.movieWatchlist,
    this.tvWatchlist,
    this.isLoading = false,
    this.errorMessage,
  });

  WatchlistState copyWith({
    List<MovieResults>? movieWatchlist,
    List<MovieResults>? tvWatchlist,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WatchlistState(
      movieWatchlist: movieWatchlist ?? this.movieWatchlist,
      tvWatchlist: tvWatchlist ?? this.tvWatchlist,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [movieWatchlist, tvWatchlist, isLoading, errorMessage];
}
