// lib/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_naura/model/amiibo.dart';

class ApiService {
  final String baseUrl = 'https://www.amiiboapi.com/api/amiibo';

  Future<List<Amiibo>> fetchAmiibo() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['amiibo'];
      return body.map((dynamic item) => Amiibo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load amiibo');
    }
  }
}