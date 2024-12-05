import 'package:flutter/material.dart';
import 'package:responsi_naura/model/amiibo.dart';
import 'package:responsi_naura/services/api_service.dart';
import 'package:responsi_naura/services/local_storage_service.dart';
import 'detail_screen.dart';
import 'favorite_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Amiibo>> futureAmiibo;
  List<Amiibo> favoriteAmiibo = [];

  @override
  void initState() {
    super.initState();
    futureAmiibo = ApiService().fetchAmiibo();
    loadFavorites();
  }

  void loadFavorites() async {
    favoriteAmiibo = await LocalStorageService().getFavorites();
    setState(() {});
  }

  void toggleFavorite(Amiibo amiibo) {
    setState(() {
      if (favoriteAmiibo.contains(amiibo)) {
        favoriteAmiibo.remove(amiibo);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${amiibo.name} removed from favorites!')),
        );
      } else {
        favoriteAmiibo.add(amiibo);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${amiibo.name} added to favorites!')),
        );
      }
    });
    LocalStorageService().saveFavorites(favoriteAmiibo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amiibo List'),
      ),
      body: FutureBuilder<List<Amiibo>>(
        future: futureAmiibo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          }

          List<Amiibo> amiiboList = snapshot.data!;
          
          return Column(
            children: [
              // Menambahkan tulisan "Nintendo Amiibo List" di tengah
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  'Nintendo Amiibo List',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Warna teks
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: amiiboList.length,
                  itemBuilder: (context, index) {
                    final amiibo = amiiboList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(amiibo: amiibo),
                            ),
                          );
                        },
                        leading: Image.network(amiibo.image),
                        title: Text(amiibo.name),
                        subtitle: Text(amiibo.gameSeries),
                        trailing: IconButton(
                          icon: Icon(
                            favoriteAmiibo.contains(amiibo)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoriteAmiibo.contains(amiibo) ? Colors.red : null,
                          ),
                          onPressed: () => toggleFavorite(amiibo),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoriteScreen(favoriteAmiibo: favoriteAmiibo),
              ),
            );
          }
        },
      ),
    );
  }
}