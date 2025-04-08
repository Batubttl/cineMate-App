// lib/presentation/cubit/search/search_state.dart
import 'package:cinemate_app/data/model/movie_model.dart';

class SearchState {
  final bool isLoading;
  final String? errorMessage;
  final List<MovieResults>? searchResults;
  final String searchQuery;

  const SearchState({
    this.isLoading = false,
    this.errorMessage,
    this.searchResults,
    this.searchQuery = '',
  });

  SearchState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MovieResults>? searchResults,
    String? searchQuery,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchResults: searchResults ?? this.searchResults,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
