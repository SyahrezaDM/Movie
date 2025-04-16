import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/media_model.dart';

const String apiKey = 'dfac00b17ade9b4862f46f83873beb9d'; 
const String baseUrl = 'https://api.themoviedb.org/3';
const String imageUrl = 'https://image.tmdb.org/t/p/w500';

class ApiService {
  static Future<List<MediaItem>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=1'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((e) => MediaItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<List<MediaItem>> fetchPopularTv() async {
    final response = await http.get(Uri.parse('$baseUrl/tv/popular?api_key=$apiKey&language=en-US&page=1'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((e) => MediaItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load TV series');
    }
  }
}
