import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/presentation/widget/movie_card.dart';
import 'package:flutter/material.dart';

class MovieGrid extends StatelessWidget {
  final List<dynamic> movies;
  final String emptyMessage;

  const MovieGrid({
    Key? key,
    required this.movies,
    required this.emptyMessage,
  }) : super(key: key);

  MovieResults _convertToMovie(dynamic item) {
    return MovieResults(
      id: item.id,
      title: item.title,
      posterPath: item.posterPath,
      backdropPath: item.backdropPath,
      voteAverage: item.voteAverage ?? 0.0,
      overview: '',
      releaseDate: '',
      originalTitle: item.title,
      originalLanguage: '',
      adult: false,
      genreIds: [],
      popularity: 0,
      video: false,
      voteCount: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Text(emptyMessage),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final item = movies[index];
        final movie = _convertToMovie(item);
        return MovieCard(movie: movie);
      },
    );
  }
}
