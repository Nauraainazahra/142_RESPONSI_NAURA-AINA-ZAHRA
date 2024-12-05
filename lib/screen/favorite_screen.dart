// lib/favorite_screen.dart
import 'package:flutter/material.dart';
import 'package:responsi_naura/model/amiibo.dart';
import 'package:responsi_naura/services/local_storage_service.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Amiibo> favoriteAmiibo;

  FavoriteScreen({required this.favoriteAmiibo});

  void removeFavorite(BuildContext context, Amiibo amiibo, int index) {
    LocalStorageService().removeFavorite(amiibo);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${amiibo.name} removed from favorites!')),
    );
    favoriteAmiibo.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Amiibo'),
      ),
      body: favoriteAmiibo.isEmpty
          ? Center(child: Text('No favorite Amiibo added.'))
          : ListView.builder(
              itemCount: favoriteAmiibo.length,
              itemBuilder: (context, index) {
                final amiibo = favoriteAmiibo[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(amiibo.image),
                    title: Text(amiibo.name),
                    subtitle: Text(amiibo.character),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        removeFavorite(context, amiibo, index);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}