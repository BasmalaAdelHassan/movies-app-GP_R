import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_response.dart';
import 'api_constant.dart';

class ApiSimilar{
  static Future<Movie?> getMovieSuggestion(int movieId) async {
    try {
      Uri url = Uri.parse('${ApiSimilarConstat.baseUrl}${ApiSimilarConstat.endpoint}?movie_id=$movieId');
      var response = await http.get(url);
      var dataJason = jsonDecode(response.body);
      return Movie.fromJson(dataJason);
    }
    catch (e) {
      rethrow;
    }
  }
}
