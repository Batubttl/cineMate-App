import 'dart:convert';
import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/enum/media_type.dart';
import 'package:cinemate_app/data/model/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFavoriteService {
  static const _favoritesKey = 'local_favorite';
  static const _lastUpdatedKey = 'local_favorite_last_updated';
  final SharedPreferences _prefs;

  LocalFavoriteService(this._prefs);

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
      throw Exception('${AppString.errorFavorites}: $e');
    }
  }

  Future<List<FavoriteItem>> getFavoritesByType(MediaType type) async {
    try {
      final allFavorites = await getFavorites();
      return allFavorites.where((item) => item.mediaType == type).toList();
    } catch (e) {
      throw Exception('${AppString.errorFavorites}: $e');
    }
  }

  Future<void> _saveFavorites(List<FavoriteItem> favorites) async {
    try {
      final response = FavoriteResponse(
        page: 1,
        results: favorites,
        totalPages: 1,
        totalResults: favorites.length,
      );

      final jsonString = json.encode(response.toJson());
      await _prefs.setString(_favoritesKey, jsonString);
      await _updateLastUpdated();
    } catch (e) {
      throw Exception('${AppString.errorSaveFavorited}: $e');
    }
  }

  Future<void> addFavorite(FavoriteItem item) async {
    try {
      final currentFavorites = await getFavorites();
      if (!currentFavorites.any(
        (favorite) =>
            favorite.id == item.id && favorite.mediaType == item.mediaType,
      )) {
        currentFavorites.add(item);
        await _saveFavorites(currentFavorites);
      }
    } catch (e) {
      throw Exception('${AppString.errorAddFavorite}: $e');
    }
  }

  Future<void> removeFavorite(int id, MediaType type) async {
    try {
      final currentFavorites = await getFavorites();
      currentFavorites.removeWhere(
        (favorite) => favorite.id == id && favorite.mediaType == type,
      );
      await _saveFavorites(currentFavorites);
    } catch (e) {
      throw Exception('${AppString.errorRemoveFavorited}: $e');
    }
  }

  Future<bool> isFavorite(int id, MediaType type) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((item) => item.id == id && item.mediaType == type);
    } catch (e) {
      throw Exception('${AppString.errorCheckIsFavorites}: $e');
    }
  }

  Future<int> getFavoriteCount({MediaType? type}) async {
    try {
      if (type != null) {
        final typeSpecificFavorites = await getFavoritesByType(type);
        return typeSpecificFavorites.length;
      }
      final currentFavorites = await getFavorites();
      return currentFavorites.length;
    } catch (e) {
      throw Exception('${AppString.errorGetFavoriteCount}: $e');
    }
  }

  Future<void> clearFavorites() async {
    try {
      await _prefs.remove(_favoritesKey);
      await _prefs.remove(_lastUpdatedKey);
    } catch (e) {
      throw Exception('${AppString.errorClearFavorites}: $e');
    }
  }

  Future<void> clearFavoritesByType(MediaType type) async {
    try {
      final currentFavorites = await getFavorites();
      final filteredFavorites =
          currentFavorites.where((item) => item.mediaType != type).toList();
      await _saveFavorites(filteredFavorites);
    } catch (e) {
      throw Exception('${AppString.errorClearFavorites}: $e');
    }
  }

  DateTime? getLastUpdated() {
    final timestamp = _prefs.getInt(_lastUpdatedKey);
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : null;
  }

  Future<void> _updateLastUpdated() async {
    await _prefs.setInt(_lastUpdatedKey, DateTime.now().millisecondsSinceEpoch);
  }
}
