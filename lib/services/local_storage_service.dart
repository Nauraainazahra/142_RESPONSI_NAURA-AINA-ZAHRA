// lib/local_storage_service.dart
import 'package:responsi_naura/model/amiibo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class LocalStorageService {
  Future<void> saveFavorites(List<Amiibo> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteStrings = favorites.map((amiibo) => json.encode(amiibo.toJson())).toList();
    await prefs.setStringList('favorites', favoriteStrings);
  }

  Future<List<Amiibo>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favoriteStrings = prefs.getStringList('favorites');
    if (favoriteStrings == null) return [];
    return favoriteStrings.map((string) => Amiibo.fromJson(json.decode(string))).toList();
  }

  Future<void> removeFavorite(Amiibo amiibo) async {
    final favorites = await getFavorites();
    favorites.remove(amiibo);
    await saveFavorites(favorites);
  }

  void toggleFavorite(Amiibo amiibo) async {
    final favorites = await getFavorites();
    if (favorites.contains(amiibo)) {
      favorites.remove(amiibo);
    } else {
      favorites.add(amiibo);
    }
    await saveFavorites(favorites);
  }
}