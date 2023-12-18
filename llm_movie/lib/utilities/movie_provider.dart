import 'package:flutter/material.dart';
import 'package:llm_movie/utilities/movie_class.dart';

class MovieProvider with ChangeNotifier {
  Movie _movie = Movie(
    title: 'No movie found',
    description: '',
    releaseYear: '',
    rating: '',
    posterPath: '',
    tmdbId: '',
    streamInfo: [],
  );

  Movie get movie => _movie;

  void setMovie(Movie movie) {
    _movie = movie;
    notifyListeners();
  }
}
