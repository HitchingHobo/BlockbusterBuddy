import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:llm_movie/api/api.dart';
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
      home: HomePage(title: 'LLM Movie Homepage'),
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
    Movie movie = context.watch<MovieProvider>().movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.releaseYear,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.rating,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.tmdbId,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.fetchDate,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.streamInfo.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getMovie(context, FilmApi(dio));
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

Future<void> getMovie(BuildContext context, FilmApi filmApi,
    {bool forceFetch = true}) async {
  if (forceFetch) {
    if (kDebugMode) {
      print('Fetching movie');
    }
    try {
      final Movie movie = await filmApi.fetchMovie();

      Provider.of<MovieProvider>(context, listen: false).setMovie(movie);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching movie: $e');
      }
    }
  } else {
    final Movie movie = Movie(
      title: 'No movie found',
      description: '',
      releaseYear: '',
      rating: '',
      posterPath: '',
      tmdbId: '',
      streamInfo: [],
      fetchDate: '',
    );

    Provider.of<MovieProvider>(context, listen: false).setMovie(movie);
  }
}
