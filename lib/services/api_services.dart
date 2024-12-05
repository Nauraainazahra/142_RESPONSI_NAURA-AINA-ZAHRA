import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_naura/model/anime_model.dart';

class ApiService {
  final String baseUrl = 'https://www.amiiboapi.com/';
  
  get animesData => null;
  
  get anime => null;

  // Fetch meal list
  Future<List<AnimeModel>> fetchMeals() async {
    final response = await http.get(Uri.parse('$baseUrl//api/amiibo/?gameseries=0x22c'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List animeData = data['meals'];
      return animesData.map((AnimeModel) => AnimeModel.fromJson(anime)).toList();
    } else {
      throw Exception('Failed to load A');
    }
  }

  // Fetch meal details by id
  Future<AnimeModel> fetchMealDetails(String mealId) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$anime'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final animesData = data['anime'][0];  // Ambil data meal pertama
      return AnimeModel.fromJson(animesData);  // Mengonversi JSON ke objek Meal
    } else {
      throw Exception('Failed to load meal details');
    }
  }
}
