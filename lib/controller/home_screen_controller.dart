import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/model/movie_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  bool isLoading = false;
  MovieModel? movies;

  fetchMovie() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://hoblist.com/api/movieList");
    final respose = await http.post(
      url,
      body: jsonEncode({
        "category": "movies",
        "language": "telugu",
        "genre": "all",
        "sort": "voting",
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (respose.statusCode == 200) {
      movies = MovieModel.fromJson(jsonDecode(respose.body));
    }
    isLoading = false;
    notifyListeners();
  }
}
