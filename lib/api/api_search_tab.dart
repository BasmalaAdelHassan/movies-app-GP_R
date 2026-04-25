import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_response.dart';
import 'api_constant.dart';

class ApiSearchTab {
  static Future<List<Movies>> getMovies() async {
    try {
      Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.endpoint);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        Movie movieResponse = Movie.fromJson(json);

        return movieResponse.data?.movies ?? [];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
