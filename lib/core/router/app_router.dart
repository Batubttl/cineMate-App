import 'package:cinemate_app/core/constant/route_constant.dart';
import 'package:cinemate_app/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:cinemate_app/presentation/pages/favorite_page.dart';
import 'package:cinemate_app/presentation/pages/home_page.dart';
import 'package:cinemate_app/presentation/pages/movie_detail_page.dart';
import 'package:cinemate_app/presentation/pages/search_page.dart';
import 'package:cinemate_app/presentation/pages/watchlist_page.dart';
import 'package:cinemate_app/presentation/widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final NavigationCubit navigationCubit;

  AppRouter(this.navigationCubit);

  late final router = GoRouter(
    initialLocation: RouteConstant.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: const BottomNavBar(),
          );
        },
        routes: [
          GoRoute(
            path: RouteConstant.home,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: RouteConstant.movieDetail,
                builder: (context, state) {
                  final movieId = int.parse(state.pathParameters['id']!);
                  return MovieDetailScreen(movieId: movieId);
                },
              ),
            ],
          ),
          GoRoute(
            path: RouteConstant.search,
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: RouteConstant.watchlist,
            builder: (context, state) => const WatchListScreen(),
          ),
          GoRoute(
            path: RouteConstant.favorites,
            builder: (context, state) => const FavoriteScreen(),
          ),
        ],
      ),
    ],
  );
}
