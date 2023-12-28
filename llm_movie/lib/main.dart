import 'package:flutter/material.dart';
import 'package:llm_movie/api/api.dart';
import 'package:llm_movie/search_page.dart';
import 'package:provider/provider.dart';
import 'package:llm_movie/utilities/movie_class.dart';
import 'package:llm_movie/utilities/movie_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LLM Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'LLM Movie Homepage'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Movie search',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    List<Movie> movies =
                        await FilmApi(dio).fetchMovies(searchController.text);
                    movieProvider.setMovies(movies);
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: FilmApi(dio).fetchMovies(searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Movie> movies = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      Movie movie = movies[index];
                      return ExpansionTile(
                        title: Text(movie.title),
                        subtitle: Text(movie.releaseYear),
                        children: [
                          Text(movie.description),
                          Text(movie.rating),
                          Image.network(movie.posterPath),
                          Text(movie.tmdbId),
                          Text(movie.streamInfo.toString()),
                          Text(movie.genres.toString()),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
