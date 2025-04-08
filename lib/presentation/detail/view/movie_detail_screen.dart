import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/enum/media_type.dart';
import 'package:cinemate_app/core/extension/string_extension.dart';
import 'package:cinemate_app/core/theme/app_colors.dart';
import 'package:cinemate_app/core/theme/text_styles.dart';
import 'package:cinemate_app/init/di/locator.dart';
import 'package:cinemate_app/presentation/detail/cubit/detail_cubit.dart';
import 'package:cinemate_app/presentation/detail/cubit/detail_state.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_state.dart';
import 'package:cinemate_app/presentation/widget/cast_list.dart';
import 'package:cinemate_app/presentation/widget/similar_movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              locator<DetailCubit>()..fetchMovieDetail(movieId),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<DetailCubit, DetailState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage!),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<DetailCubit>().fetchMovieDetail(movieId);
                      },
                      child: const Text(AppString.tryAgain),
                    ),
                  ],
                ),
              );
            }
            final movieDetail = state.movieDetail;
            if (movieDetail == null) {
              return const Center(
                child: Text(AppString.notFindMovies),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  actions: [
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, favoriteState) {
                        final isFavorite = favoriteState.movieFavorites?.any(
                              (favorite) => favorite.id == movieDetail.id,
                            ) ??
                            false;

                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? AppColors.error
                                : AppColors.textPrimary,
                          ),
                          onPressed: () {
                            locator<FavoriteCubit>().toggleFavorite(
                              item: movieDetail,
                              mediaType: MediaType.movie,
                            );
                          },
                        );
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          movieDetail.backdropPath!.toBackdropUrl(),
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: AppColors.posterGradient,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  movieDetail.posterPath.toPosterUrl(),
                                  height: 150,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      movieDetail.title,
                                      style: AppTextStyles.headline2,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.textSecondary,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            movieDetail.releaseDate
                                                .split('-')[0],
                                            style: AppTextStyles.bodyMedium,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${movieDetail.runtime} ${AppString.minuteMovie}',
                                          style: AppTextStyles.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          children: movieDetail.genres.map((genre) {
                            return Chip(
                              label: Text(
                                genre.name,
                                style: AppTextStyles.bodyMedium,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          AppString.overview,
                          style: AppTextStyles.movieInfo,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movieDetail.overview,
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          AppString.cast,
                          style: AppTextStyles.movieInfo,
                        ),
                        const SizedBox(height: 16),
                        CastList(
                          cast: movieDetail.cast,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                if (movieDetail.similarMovies.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            AppString.similarMovies,
                            style: AppTextStyles.movieInfo,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SimilarMoviesList(
                          similarMovies: movieDetail.similarMovies,
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
