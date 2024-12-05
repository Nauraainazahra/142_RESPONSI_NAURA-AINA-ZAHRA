// lib/amiibo.dart
class Amiibo {
  final String amiiboSeries;
  final String character;
  final String gameSeries;
  final String head;
  final String image;
  final String name;
  final String type;

  Amiibo({
    required this.amiiboSeries,
    required this.character,
    required this.gameSeries,
    required this.head,
    required this.image,
    required this.name,
    required this.type,
  });

  factory Amiibo.fromJson(Map<String, dynamic> json) {
    return Amiibo(
      amiiboSeries: json['amiiboSeries'],
      character: json['character'],
      gameSeries: json['gameSeries'],
      head: json['head'],
      image: json['image'],
      name: json['name'],
      type: json['type'],
    );
  }

  get release => null;

  Map<String, dynamic> toJson() {
    return {
      'amiiboSeries': amiiboSeries,
      'character': character,
      'gameSeries': gameSeries,
      'head': head,
      'image': image,
      'name': name,
      'type': type,
    };
  }
}