import 'package:dio/dio.dart';
import 'package:llm_movie/api/api.dart';
import 'package:llm_movie/utilities/data_classes.dart';
import 'package:flutter/material.dart';

import 'package:llm_movie/widgets/movie_card.dart';

class MovieService {
  static Future<List<Movie>> fetchMovies(Llmprompt prompt) async {
    String finalPrompt = prompt.createPrompt();
    List<dynamic> llmRecommendation = await fetchRecommendations(finalPrompt);

    List<Movie> movies = [];
    for (Map<String, dynamic> movie in llmRecommendation) {
      String title = movie['title'];
      String explanation = movie['explanation'];

      List<Movie> fetchedMovies = await FilmApi(Dio()).fetchMovies(title);
      if (fetchedMovies.isNotEmpty) {
        fetchedMovies.first.explanation = explanation;
        movies.add(fetchedMovies.first);
      }
    }

    return movies;
  }
}

class Resultspage extends StatefulWidget {
  final Llmprompt prompt;

  Resultspage({Key? key, required this.prompt}) : super(key: key);

  @override
  State<Resultspage> createState() => _ResultspageState();
}

class _ResultspageState extends State<Resultspage> {
  List<Movie>? _fetchedMovies;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  void _fetchMovies() async {
    List<Movie> movies = await MovieService.fetchMovies(widget.prompt);

    setState(() {
      _fetchedMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Center(
        child: _buildResult(),
      ),
    );
  }

  Widget _buildResult() {
    if (_fetchedMovies == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: _fetchedMovies!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              MovieCard(movie: _fetchedMovies![index]),
              if (_fetchedMovies![index].explanation == null)
                const SizedBox.shrink()
              else
                Text(_fetchedMovies![index].explanation!),
            ],
          );
        },
      );
    }
  }
}
