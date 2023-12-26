import 'package:flutter/material.dart';
import 'package:llm_movie/utilities/movie_class.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  void setMovies(List<Movie> movies) {
    _movies = movies;
    notifyListeners();
  }
}
