import 'package:flutter/material.dart';
import 'package:llm_movie/utilities/data_classes.dart';
import 'package:llm_movie/widgets/textstyles.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    String releaseYear = movie.releaseDate.length >= 4
        ? movie.releaseDate.substring(0, 4)
        : 'Release not found';
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            movie.posterPath,
            width: double.infinity,
            height: 270.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: BodyText(
              text: '($releaseYear)',
            ),
          ),
        ],
      ),
    );
  }
}
