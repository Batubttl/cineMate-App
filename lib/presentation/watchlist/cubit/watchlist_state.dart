import 'package:equatable/equatable.dart';
import 'package:cinemate_app/data/model/movie_model.dart';

class WatchlistState extends Equatable {
  final List<MovieResults> watchlist;
  final bool isLoading;
  final String? errorMessage;

  const WatchlistState({
    this.watchlist = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  factory WatchlistState.initial() {
    return const WatchlistState();
  }

  WatchlistState copyWith({
    List<MovieResults>? watchlist,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WatchlistState(
      watchlist: watchlist ?? this.watchlist,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [watchlist, isLoading, errorMessage];
}
