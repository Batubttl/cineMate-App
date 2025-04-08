import 'package:cinemate_app/data/service/movie_service.dart';
import 'package:cinemate_app/presentation/search/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final MovieService _movieService;
  final TextEditingController _controller = TextEditingController();

  SearchCubit(this._movieService) : super(const SearchState());

  TextEditingController get controller => _controller;

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchResults: [],
          searchQuery: query,
          isLoading: false,
        ),
      );
      return;
    }

    try {
      emit(
        state.copyWith(
          isLoading: true,
          searchQuery: query,
          errorMessage: null,
        ),
      );

      final results = await _movieService.searchMovies(query);

      emit(
        state.copyWith(
          isLoading: false,
          searchResults: results,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Arama sırasında bir hata oluştu: $e',
        ),
      );
    }
  }

  void clearSearch() {
    _controller.clear();
    emit(const SearchState());
  }
}
