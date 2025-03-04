import 'package:cinemate_app/core/network/dio/dio_manager.dart';
import 'package:cinemate_app/data/service/movie_service.dart';
import 'package:cinemate_app/data/service/person_service.dart';
import 'package:cinemate_app/data/service/search_service.dart';
import 'package:cinemate_app/data/service/tv_service.dart';
import 'package:cinemate_app/presentation/cubit/movie/movie_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  void setupLocator() {
    locator.registerLazySingleton<Dio>(() => DioManager.instance.dio);

    locator.registerLazySingleton<MovieService>(
        () => MovieService(locator<Dio>()));

    locator.registerLazySingleton<TVService>(() => TVService(locator<Dio>()));
    locator.registerLazySingleton<SearchService>(
        () => SearchService(locator<Dio>()));

    locator.registerLazySingleton<PersonService>(
        () => PersonService(locator<Dio>()));
  }
}
