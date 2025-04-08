import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/router/app_router.dart';
import 'package:cinemate_app/core/theme/app_theme.dart';
import 'package:cinemate_app/init/di/locator.dart';
import 'package:cinemate_app/init/navigation/navigation_cubit.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:cinemate_app/presentation/home/cubit/movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await setupLocator();

  final navigationCubit = NavigationCubit();
  final appRouter = AppRouter(navigationCubit);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => navigationCubit),
        BlocProvider(create: (_) => locator<MovieCubit>()..loadHomePageData()),
        BlocProvider(create: (_) => locator<FavoriteCubit>()),
      ],
      child: MaterialApp.router(
        title: AppString.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: appRouter.router,
      ),
    ),
  );
}
