import 'package:cinemate_app/data/model/favorite_model.dart';
import 'package:cinemate_app/data/model/movie_model.dart';

extension FavoriteItemExtension on FavoriteItem {
  MovieResults toMovieResults() {
    return MovieResults(
      id: id,
      title: title,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage ?? 0.0,
      overview: '',
      releaseDate: '',
      originalTitle: title,
      originalLanguage: '',
      adult: false,
      genreIds: [],
      popularity: 0,
      video: false,
      voteCount: 0,
    );
  }
}
