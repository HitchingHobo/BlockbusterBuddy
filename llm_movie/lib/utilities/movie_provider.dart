import 'package:flutter/material.dart';
import 'package:llm_movie/utilities/data_classes.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  void setMovies(List<Movie> movies) {
    _movies = movies;
    notifyListeners();
  }
}
