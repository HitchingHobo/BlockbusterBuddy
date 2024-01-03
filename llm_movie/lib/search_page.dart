import 'package:flutter/material.dart';
import 'package:llm_movie/api/api.dart';
import 'package:llm_movie/utilities/data_classes.dart';
import 'package:llm_movie/utilities/movie_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Movie search',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Movie> movies =
                    await FilmApi(dio).fetchMovies(searchController.text);
                // Assuming you want to show the first movie from the search results
                if (movies.isNotEmpty) {
                  movieProvider.setMovies(movies.first as List<Movie>);
                }
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
