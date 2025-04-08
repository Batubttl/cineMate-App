import 'package:cinemate_app/core/extension/string_extension.dart';
import 'package:cinemate_app/core/theme/app_colors.dart';
import 'package:cinemate_app/core/theme/text_styles.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/presentation/detail/view/movie_detail_screen.dart';
import 'package:flutter/material.dart';

class SimilarMoviesList extends StatelessWidget {
  final List<MovieResults> similarMovies;

  const SimilarMoviesList({Key? key, required this.similarMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: similarMovies.length,
        itemBuilder: (context, index) {
          final similarMovie = similarMovies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(
                    movieId: similarMovie.id,
                  ),
                ),
              );
            },
            child: Container(
              width: 200,
              margin: EdgeInsets.only(
                left: index == 0 ? 16 : 8,
                right: index == similarMovies.length - 1 ? 16 : 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: similarMovie.posterPath != null
                        ? Image.network(
                            similarMovie.posterPath!.toPosterUrl(),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 200,
                            width: double.infinity,
                            color: AppColors.primaryColor,
                            child: const Center(
                              child: Icon(
                                Icons.movie,
                                size: 40,
                                color: AppColors.error,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    similarMovie.title,
                    style: AppTextStyles.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
