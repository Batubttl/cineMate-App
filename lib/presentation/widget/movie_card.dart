import 'package:cinemate_app/core/constant/api_constant.dart';
import 'package:cinemate_app/core/constant/route_constant.dart';
import 'package:cinemate_app/core/enum/media_type.dart';
import 'package:cinemate_app/core/theme/app_colors.dart';
import 'package:cinemate_app/core/theme/text_styles.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/init/di/locator.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_state.dart';
import 'package:cinemate_app/presentation/watchlist/cubit/watchlist_cubit.dart';
import 'package:cinemate_app/presentation/watchlist/cubit/watchlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MovieCard extends StatelessWidget {
  final MovieResults movie;
  final bool isCarouselView;
  final MediaType mediaType;

  const MovieCard({
    super.key,
    required this.movie,
    this.isCarouselView = false,
    this.mediaType = MediaType.movie,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: locator<WatchlistCubit>(),
        ),
      ],
      child: GestureDetector(
        onTap: () => context.go(RouteConstant.movieDetailPath(movie.id)),
        child: Container(
          width: isCarouselView ? 320 : 180,
          height: isCarouselView ? 260 : 340,
          margin: EdgeInsets.symmetric(
            horizontal: isCarouselView ? 8 : 6,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Poster Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        ApiConstant.getPosterUrl(
                          isCarouselView
                              ? movie.backdropPath ?? movie.posterPath ?? ''
                              : movie.posterPath ?? '',
                        ),
                        fit: isCarouselView ? BoxFit.cover : BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.surface,
                            child: const Center(
                              child: Icon(
                                Icons.error_outline,
                                color: AppColors.textSecondary,
                                size: 32,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppColors.surface,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.background.withOpacity(0.4),
                            AppColors.background.withOpacity(0.8),
                          ],
                          stops: const [0.6, 0.8, 1.0],
                        ),
                      ),
                    ),
                    // Movie Info Overlay
                    Positioned(
                      left: 8,
                      right: 8,
                      bottom: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: AppTextStyles.movieTitle.copyWith(
                              fontSize: isCarouselView ? 16 : 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              letterSpacing: 0.3,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (movie.releaseDate != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.textSecondary
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    movie.releaseDate!.split('-')[0],
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textPrimary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: AppColors.warning,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      movie.voteAverage?.toStringAsFixed(1) ??
                                          '0.0',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textPrimary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Favorite Button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: BlocBuilder<FavoriteCubit, FavoriteState>(
                          builder: (context, state) {
                            final isFavorite = state.movieFavorites?.any(
                                  (f) => f.id == movie.id,
                                ) ??
                                false;

                            return IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? AppColors.error
                                    : AppColors.textPrimary,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                              onPressed: () {
                                locator<FavoriteCubit>().toggleFavorite(
                                  item: movie,
                                  mediaType: MediaType.movie,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // Watchlist Button
                    // Watchlist Button
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: BlocBuilder<WatchlistCubit, WatchlistState>(
                          builder: (context, state) {
                            final isInWatchlist = locator<WatchlistCubit>()
                                .isInWatchlist(movie.id);

                            return IconButton(
                              icon: Icon(
                                isInWatchlist
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: isInWatchlist
                                    ? AppColors.accentColor
                                    : AppColors.textPrimary,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                              onPressed: () {
                                locator<WatchlistCubit>().toggleWatchlist(
                                  item: movie,
                                  mediaType: MediaType.movie,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
