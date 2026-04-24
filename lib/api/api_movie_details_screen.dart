import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_details_response.dart';
import 'api_constant.dart';

class ApiMovieDetailsScreen {
  static Future<MovieDetailsResponse?> getMovieDetails(int movieId) async {
    try {
      final url = Uri.parse(
        "${ApiDetailsConstat.baseUrl}${ApiDetailsConstat.endpoint}?movie_id=$movieId&with_images=true&with_cast=true",
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return MovieDetailsResponse.fromJson(jsonData);
      } else {
        throw Exception("Failed to load movie details");
      }
    } catch (e) {
      return MovieDetailsResponse(
        statusMessage: e.toString(),
      );
    }
  }

  static Future<Movie?> getMoviesList(int movieId) async {
    try {
      Uri url = Uri.parse('https://movies-api.accel.li/api/v2/list_movies.json?limit=20');
      final response = await http.get(url);
      final jsonData = jsonDecode(response.body);
      return Movie.fromJson(jsonData);
    } catch (e) {
      throw e.toString();
    }
  }
}
