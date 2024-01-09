import 'package:dio/dio.dart';
import 'package:llm_movie/api/api.dart';
import 'package:llm_movie/utilities/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:llm_movie/widgets/formatting_widget.dart';
import 'package:llm_movie/widgets/textstyles.dart';

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

  const Resultspage({Key? key, required this.prompt}) : super(key: key);

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
        title: const Text('Recommendations'),
      ),
      body: Center(
        child: _buildResult(),
      ),
    );
  }

  Widget _buildResult() {
    if (_fetchedMovies == null) {
      return const LoadingText();
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Fresh off the presses\nYour AI-curator recommends',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _fetchedMovies!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Card(
                              margin: const EdgeInsets.all(8.0),
                              elevation: 8,
                              child: Image.network(
                                  _fetchedMovies![index].posterPath),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 2.0),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: TitleText(
                                        text:
                                            '${_fetchedMovies![index].title} (${_fetchedMovies![index].releaseDate.substring(0, 4)})'),
                                  ),
                                  Text(
                                    _fetchedMovies![index].explanation ?? '',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
