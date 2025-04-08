import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/data/model/movie_model.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_state.dart';
import 'package:cinemate_app/presentation/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  MovieResults _convertFavoriteToMovie(dynamic favorite) {
    return MovieResults(
      id: favorite.id,
      title: favorite.title,
      posterPath: favorite.posterPath,
      backdropPath: favorite.backdropPath,
      voteAverage: favorite.voteAverage ?? 0.0,
      overview: '',
      releaseDate: '',
      originalTitle: favorite.title,
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppString.favoritePage),
          actions: [
            BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                if (state.movieFavorites?.isNotEmpty ?? false) {
                  return IconButton(
                    icon: const Icon(Icons.delete_sweep),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(AppString.clearAllFavorites),
                          content: const Text(
                            AppString.clearAllFavoritesConfirmation,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(AppString.cancel),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<FavoriteCubit>()
                                    .clearAllFavorites();
                                Navigator.pop(context);
                              },
                              child: const Text(AppString.clear),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hata: ${state.errorMessage}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<FavoriteCubit>().loadFavorites(),
                      child: const Text(AppString.tryAgain),
                    ),
                  ],
                ),
              );
            }

            return TabBarView(
              children: [
                _buildMovieList(state.movieFavorites ?? []),
                _buildTvList(state.tvFavorites ?? []),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMovieList(List<dynamic> favorites) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text(AppString.noFavoriteMovies),
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
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final favoriteItem = favorites[index];
        final movie = _convertFavoriteToMovie(favoriteItem);
        return MovieCard(movie: movie);
      },
    );
  }

  Widget _buildTvList(List<dynamic> favorites) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text(AppString.noFavoriteTvShows),
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
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final favoriteItem = favorites[index];
        final movie = _convertFavoriteToMovie(favoriteItem);
        return MovieCard(movie: movie);
      },
    );
  }
}
