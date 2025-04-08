import 'package:cinemate_app/core/network/dio/dio_manager.dart';
import 'package:cinemate_app/data/service/local_favorite_service.dart';
import 'package:cinemate_app/data/service/movie_detail_service.dart';
import 'package:cinemate_app/data/service/movie_service.dart';
import 'package:cinemate_app/data/service/person_service.dart';
import 'package:cinemate_app/data/service/search_service.dart';
import 'package:cinemate_app/data/service/tv_service.dart';
import 'package:cinemate_app/init/navigation/navigation_cubit.dart';
import 'package:cinemate_app/presentation/detail/cubit/detail_cubit.dart';
import 'package:cinemate_app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:cinemate_app/presentation/home/cubit/movie_cubit.dart';
import 'package:cinemate_app/presentation/search/cubit/search_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<Dio>(() => DioManager.instance.dio);

  locator
      .registerLazySingleton<MovieService>(() => MovieService(locator<Dio>()));
  locator.registerLazySingleton<TVService>(() => TVService(locator<Dio>()));
  locator.registerLazySingleton<SearchService>(
    () => SearchService(locator<Dio>()),
  );
  locator.registerLazySingleton<PersonService>(
    () => PersonService(locator<Dio>()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  locator.registerLazySingleton<LocalFavoriteService>(
    () => LocalFavoriteService(locator<SharedPreferences>()),
  );

  locator.registerLazySingleton<FavoriteCubit>(
    () => FavoriteCubit(locator<LocalFavoriteService>()),
  );
  locator.registerLazySingleton(() => MovieDetailService(locator()));

  locator.registerFactory(() => DetailCubit(locator()));

  locator.registerLazySingleton<MovieCubit>(
    () => MovieCubit(movieService: locator<MovieService>()),
  );
  locator.registerLazySingleton<NavigationCubit>(() => NavigationCubit());

  locator.registerFactory(() => SearchCubit(locator<MovieService>()));
}
