import 'package:cinemate_app/data/model/movie_detail_model.dart';
import 'package:equatable/equatable.dart';

class DetailState extends Equatable {
  final MovieDetail? movieDetail;
  final bool isLoading;
  final String? errorMessage;

  const DetailState({
    this.movieDetail,
    this.isLoading = false,
    this.errorMessage,
  });

  DetailState copyWith({
    MovieDetail? movieDetail,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [movieDetail, isLoading, errorMessage];
}
