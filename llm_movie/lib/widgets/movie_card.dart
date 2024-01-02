import 'package:flutter/material.dart';
import 'package:llm_movie/utilities/movie_class.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          Image.network(
            movie.posterPath,
            width: double.infinity,
            height: 300.0,
            fit: BoxFit.cover,
          ),
          // Movie Title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
              overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
              maxLines: 2,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          // Release Year
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              'Release Date: ${movie.releaseDate}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
