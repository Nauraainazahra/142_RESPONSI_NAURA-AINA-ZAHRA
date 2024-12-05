import 'package:flutter/material.dart';
import 'package:responsi_naura/model/anime_model.dart';
import 'package:responsi_naura/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<String>> _favoriteAnime;

  @override
  void initState() {
    super.initState();
    _favoriteAnime = _loadFavorites();
  }

  // Memuat daftar favorit dari SharedPreferences
  Future<List<String>> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Anime'),
      ),
      body: FutureBuilder<List<String>>(
        future: _favoriteAnime, // Memuat daftar ID makanan favorit
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final favoriteAnimeIds = snapshot.data!;
            
            return FutureBuilder<List<AnimeModel>>(
              future: ApiService().fet(),
              builder: (context, mealSnapshot) {
                if (mealSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (animeSnapshot.hasError) {
                  return Center(child: Text('Error: ${animeSnapshot.error}'));
                } else if (mealSnapshot.hasData) {
                  final AnimeModel = mealSnapshot.data!;
                  final favoriteMeals = AnimeModel.where((AnimeModel) => favoriteAnimeIds.contains(AnimeModel.id)).toList();

                  return ListView.builder(
                    itemCount: favoriteMeals.length,
                    itemBuilder: (context, index) {
                      final anime = favoriteAnimeIds[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(anime.name),
                          leading: Image.network(
                            anime.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(anime), // Navigate to detail screen
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No anime available'));
                }
              },
            );
          } else {
            return const Center(child: Text('No favorite anime found.'));
          }
        },
      ),
    );
  }
}
