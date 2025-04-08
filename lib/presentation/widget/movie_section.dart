import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemate_app/core/enum/media_type.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/presentation/widget/movie_card.dart';
import 'package:flutter/material.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieResults> movies;
  final double height;
  final bool isCarousel;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    required this.height,
    this.isCarousel = false,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8),
        isCarousel
            ? CarouselSlider.builder(
                itemCount: movies.length,
                options: CarouselOptions(
                  height: height,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.6,
                ),
                itemBuilder: (context, index, realIndex) {
                  return MovieCard(
                      movie: movies[index], mediaType: MediaType.movie);
                },
              )
            : SizedBox(
                height: height,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: movies[index],
                      mediaType: MediaType.movie,
                    );
                  },
                ),
              ),
      ],
    );
  }
}
