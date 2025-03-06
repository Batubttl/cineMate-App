// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/data/model/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFavoriteService {
  static const _favoritesKey = 'local_favorite';
  static const _lastUpdatedKey = 'local_favorite_last_updated';
  final SharedPreferences _prefs;
  LocalFavoriteService({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  Future<List<FavoriteItem>> getFavorites() async {
    try {
      final jsonString = _prefs.getString(_favoritesKey);
      if (jsonString == null) {
        return [];
      }
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final response = FavoriteResponse.fromJson(jsonMap);
      return response.results;
    } catch (e) {
      throw Exception('Error getFavorites: $e');
    }
  }

  Future<void> _saveFavorites(List<FavoriteItem> favorites) async {
    try {
      final response = FavoriteResponse(
          page: 1,
          results: favorites,
          totalPages: 1,
          totalResults: favorites.length);

      final jsonString = json.encode({
        'page': response.page,
        'results': response.results.map((e) => e.toJson()).toList(),
        'total_pages': response.totalPages,
        'total_results': response.totalResults,
      });
      await _prefs.setString(_favoritesKey, jsonString);
    } catch (e) {
      throw Exception('${AppString.errorSaveFavorited}: $e');
    }
  }

  Future<void> addFavorite(FavoriteItem item) async {
    try {
      final currentFavorites = await getFavorites();
      if (!currentFavorites.any((favorite) => favorite.id == item.id)) {
        currentFavorites.add(item);
        await _saveFavorites(currentFavorites);
      }
    } catch (e) {}
  }
}
