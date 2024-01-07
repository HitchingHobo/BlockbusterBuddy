import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:llm_movie/api/api.dart';
import 'package:llm_movie/utilities/data_classes.dart';
import 'package:llm_movie/widgets/movie_card.dart';

class Resultspage extends StatefulWidget {
  final Map<String, List<Map<String, String>>> llmResults = {
    "recommendations": [
      {
        "movie_title": "Constantine",
        "year": "2005",
        "explanation":
            "Starring Keanu Reeves, 'Constantine' is a supernatural thriller with elements of horror. While it deviates from the action genre, it offers a gripping storyline and Reeves' strong performance, catering to your preference for his acting."
      },
      {
        "movie_title": "The Matrix",
        "year": "1999",
        "explanation":
            "Starring Keanu Reeves, 'The Matrix' is a classic action film known for its groundbreaking cinematography and compelling storyline. While not a horror or thriller, it showcases Reeves' acting prowess and aligns with your high ratings for story and cinematography."
      },
      {
        "movie_title": "A Walk Among the Tombstones",
        "year": "2014",
        "explanation":
            "While not featuring Keanu Reeves, 'A Walk Among the Tombstones' is a crime thriller starring Liam Neeson, known for its dark and atmospheric tone. It explores the thriller genre and involves elements of suspense and mystery."
      },
      {
        "movie_title": "Se7en",
        "year": "1995",
        "explanation":
            "Although not featuring Keanu Reeves, 'Se7en' is a psychological thriller known for its intense storyline and atmospheric cinematography. It delves into the horror and thriller genres, providing a suspenseful and gripping experience."
      }
    ]
  };

  Resultspage({Key? key}) : super(key: key);

  @override
  State<Resultspage> createState() => _ResultspageState();
}

class _ResultspageState extends State<Resultspage> {
  List<Movie>? _fetchedMovies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: _buildResults(),
    );
  }

  Widget _buildResults() {
    if (_fetchedMovies == null) {
      _fetchMovies();
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: widget.llmResults['recommendations']?.length ?? 0,
        itemBuilder: (context, index) {
          Map<String, String> recommendation =
              widget.llmResults['recommendations']![index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  MovieCard(movie: _fetchedMovies![index]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      recommendation['explanation']!,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
          );
        },
      );
    }
  }

  void _fetchMovies() async {
    List<Movie> movies = [];
    for (var recommendation in widget.llmResults['recommendations']!) {
      List<Movie> fetchedMovies =
          await FilmApi(Dio()).fetchMovies(recommendation['movie_title']!);
      if (fetchedMovies.isNotEmpty) {
        movies.add(fetchedMovies.first);
      }
    }

    setState(() {
      _fetchedMovies = movies;
    });
  }
}

// Map<String, List<Map<String, String>>> llm_results = {
//   "recommendations": [
//     {
//       "movie_title": "Constantine (2005)",
//       "explanation":
//           "Starring Keanu Reeves, 'Constantine' is a supernatural thriller with elements of horror. While it deviates from the action genre, it offers a gripping storyline and Reeves' strong performance, catering to your preference for his acting."
//     },
//     {
//       "movie_title": "The Matrix (1999)",
//       "explanation":
//           "Starring Keanu Reeves, 'The Matrix' is a classic action film known for its groundbreaking cinematography and compelling storyline. While not a horror or thriller, it showcases Reeves' acting prowess and aligns with your high ratings for story and cinematography."
//     },
//     {
//       "movie_title": "A Walk Among the Tombstones (2014)",
//       "explanation":
//           "While not featuring Keanu Reeves, 'A Walk Among the Tombstones' is a crime thriller starring Liam Neeson, known for its dark and atmospheric tone. It explores the thriller genre and involves elements of suspense and mystery."
//     },
//     {
//       "movie_title": "Se7en (1995)",
//       "explanation":
//           "Although not featuring Keanu Reeves, 'Se7en' is a psychological thriller known for its intense storyline and atmospheric cinematography. It delves into the horror and thriller genres, providing a suspenseful and gripping experience."
//     }
//   ]
// };
