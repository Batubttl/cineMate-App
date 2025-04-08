import 'package:cinemate_app/data/model/genre_model.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/presentation/widget/movie_section.dart';
import 'package:flutter/material.dart';

class MovieSectionBuilder extends StatelessWidget {
  final List<MovieResults> trendingMovies;
  final List<MovieResults> topRatedMovies;
  final List<MovieResults> popularMovies;
  final List<GenreModel> genres;
  final Map<int, List<MovieResults>> moviesByGenre;
  final double carouselHeight;

  const MovieSectionBuilder({
    super.key,
    required this.trendingMovies,
    required this.topRatedMovies,
    required this.popularMovies,
    required this.genres,
    required this.moviesByGenre,
    required this.carouselHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (trendingMovies.isNotEmpty)
            MovieSection(
              title: 'Trend Filmler',
              movies: trendingMovies,
              height: carouselHeight,
              isCarousel: true,
            ),
          const SizedBox(height: 20),
          if (popularMovies.isNotEmpty)
            MovieSection(
              title: 'Popüler Filmler',
              movies: popularMovies,
              height: carouselHeight,
            ),
          const SizedBox(height: 20),
          if (topRatedMovies.isNotEmpty)
            MovieSection(
              title: 'En Çok Oylananlar',
              movies: topRatedMovies,
              height: carouselHeight,
            ),
          const SizedBox(height: 20),
          if (genres.isNotEmpty)
            ...genres.map(
              (genre) => MovieSection(
                title: genre.name,
                movies: moviesByGenre[genre.id] ?? [],
                height: carouselHeight,
              ),
            ),
        ],
      ),
    );
  }
}
