import 'package:flutter/foundation.dart';
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
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movieProvider.movies.length,
        itemBuilder: (context, index) {
          Movie movie = movieProvider.movies[index];
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
            // Add more details or customize the UI as needed
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Fetch movies and update the MovieProvider
          List<Movie> movies = await FilmApi(dio).fetchMovies("batman");
          movieProvider.setMovies(movies);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
