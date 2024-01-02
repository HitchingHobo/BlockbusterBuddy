import 'package:flutter/material.dart';
import 'package:llm_movie/utilities/movie_class.dart';

class DetailsPage extends StatelessWidget {
  final Movie movie;

  DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            Text(movie.title),
            Text(movie.description),
            Text('Released in: ${movie.releaseYear}'),
            Text('Rating (0-10): ${movie.rating}'),
            Text('Tmdb id: ${movie.tmdbId}'),
            Text('Streaming info: ${movie.streamInfo.toString()}'),
            Text('Genres: ${movie.genres.toString()}'),
            Text('Keywords: ${movie.keywords.toString()}'),
            Text('Actors: ${movie.actors.toString()}'),
            Text('Director: ${movie.director.toString()}'),
            Image.network(movie.posterPath),
          ],
        ));
  }
}
