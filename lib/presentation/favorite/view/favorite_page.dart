import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_state.dart';
import 'package:cinemate_app/presentation/widget/movie_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              context.read<FavoriteCubit>().clearAllFavorites();
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

          return MovieGrid(
            movies: state.movieFavorites ?? [],
            emptyMessage: AppString.noFavoriteMovies,
          );
        },
      ),
    );
  }
}
