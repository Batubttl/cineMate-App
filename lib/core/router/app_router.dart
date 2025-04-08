import 'package:cinemate_app/core/constant/route_constant.dart';
import 'package:cinemate_app/init/navigation/navigation_cubit.dart';
import 'package:cinemate_app/presentation/favorite/view/favorite_page.dart';
import 'package:cinemate_app/presentation/detail/view/movie_detail_screen.dart';
import 'package:cinemate_app/presentation/home/view/home_screen.dart';
import 'package:cinemate_app/presentation/search/view/search_view.dart';
import 'package:cinemate_app/presentation/watchlist/view/watchlist_screen.dart';
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
                  final movieId = int.parse(state.pathParameters['id'] ?? '0');
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
            builder: (context, state) => const WatchlistScreen(),
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
