import 'package:flutter/material.dart';
import 'package:responsi_naura/model/amiibo.dart';
import 'package:responsi_naura/services/local_storage_service.dart';

class DetailScreen extends StatelessWidget {
final Amiibo amiibo;

DetailScreen({required this.amiibo});

void toggleFavorite(BuildContext context) {
LocalStorageService().toggleFavorite(amiibo);
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('${amiibo.name} added to favorites!')),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(amiibo.name),
actions: [
IconButton(
icon: Icon(Icons.favorite_border),
onPressed: () => toggleFavorite(context),
),
],
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Image.network(amiibo.image),
SizedBox(height: 16.0),
Text(
'Character: ${amiibo.character}',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
SizedBox(height: 8.0),
Text('Game Series: ${amiibo.gameSeries}'),
SizedBox(height: 8.0),
Text('Amiibo Series: ${amiibo.amiiboSeries}'),
SizedBox(height: 8.0),
Text('Type: ${amiibo.type}'),
],
),
),
);
}
}