import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/network/dio/dio_manager.dart';
import 'package:cinemate_app/data/service/movie_service.dart';
import 'package:cinemate_app/presentation/home/cubit/movie_cubit.dart';
import 'package:cinemate_app/presentation/home/cubit/movie_state.dart';
import 'package:cinemate_app/presentation/widget/movie_section_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(
            movieService: MovieService(DioManager.instance.dio),
          )..loadHomePageData(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppString.appName),
        ),
        body: BlocBuilder<MovieCubit, MovieState>(
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
                        context.read<MovieCubit>().loadHomePageData();
                      },
                      child: const Text(AppString.tryAgain),
                    ),
                  ],
                ),
              );
            }

            return MovieSectionBuilder(
              trendingMovies: state.trendingMovies ?? [],
              topRatedMovies: state.topRatedMovies ?? [],
              popularMovies: state.popularMovies ?? [],
              genres: state.genres ?? [],
              moviesByGenre: state.moviesByGenre ?? {},
              carouselHeight: 300,
            );
          },
        ),
      ),
    );
  }
}
