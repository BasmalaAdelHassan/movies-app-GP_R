import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_response.dart';
import 'api_constant.dart';

class ApiHomeTab {
  static Future<Movie?> getMovies() async {
    try {
      Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.endpoint);
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return Movie.fromJson(json);
    } catch (e) {
      return Movie(statusMessage: 'failed req');
    }
  }
}
