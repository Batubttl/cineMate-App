import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/theme/app_colors.dart';
import 'package:cinemate_app/core/theme/text_styles.dart';
import 'package:cinemate_app/init/di/locator.dart';
import 'package:cinemate_app/presentation/watchlist/cubit/watchlist_cubit.dart';
import 'package:cinemate_app/presentation/watchlist/cubit/watchlist_state.dart';
import 'package:cinemate_app/presentation/widget/movie_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<WatchlistCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('İzleme Listem'),
          backgroundColor: AppColors.background,
        ),
        body: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.errorMessage != null) {
              return Center(
                child: Text(state.errorMessage!),
              );
            }

            return MovieGrid(
              movies: state.watchlist,
              emptyMessage: 'İzleme listenizde film bulunmuyor.',
            );
          },
        ),
      ),
    );
  }
}
