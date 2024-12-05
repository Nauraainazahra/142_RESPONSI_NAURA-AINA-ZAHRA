class AnimeModel {
  final String amibooSeries;
  final String gameSeries;
  final String head;
  final String image;
  final String name;
  final String tail;
  final String type;


  AnimeModel({
    required this.amibooSeries,
    required this.gameSeries,
    required this.head,
    required this.image,
    required this.name,
    required this.tail,
    required this.type,
  });

  factory AnimeModel(Map<String, dynamic> json) {
    return AnimeModel(
      amibooSeries: json['amibooSeries'],
      gameSeries: json['strgameSeries'],  
      head: json['strHead'],
      image: json['strAnimeThumb'],
      name: json['strName'],
      tail: json['strTail'],
      type: json['strType'],
    );
  }

  static fromJson(anime) {}
}
