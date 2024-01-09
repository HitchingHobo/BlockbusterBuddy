import 'package:flutter/material.dart';
import 'package:llm_movie/api/api.dart';
import 'package:llm_movie/details_page.dart';
import 'package:llm_movie/testpage.dart';
import 'package:provider/provider.dart';
import 'package:llm_movie/utilities/data_classes.dart';
import 'package:llm_movie/widgets/movie_card.dart';
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
      title: 'BlockbusterBuddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'BlockbusterBuddy'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (movieProvider.movies.isEmpty)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.blue, width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 14.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to BlockBusterBuddy!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Your personal AI movie curator',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Search for a movie to base your recommendation on',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      labelText: 'Movie title search',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(20, 50)),
                  onPressed: () async {
                    List<Movie> movies =
                        await FilmApi(dio).fetchMovies(searchController.text);
                    movieProvider.setMovies(movies);
                  },
                  child: const Icon(
                    Icons.search,
                    size: 35,
                  ),
                ),
              ],
            ),
            if (movieProvider.movies.isEmpty)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 4.0),
                ),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        List<Movie> movies = await FilmApi(dio)
                            .fetchMovies(searchController.text);
                        movieProvider.setMovies(movies);
                      },
                      child: AnimatedIcon(
                        icon: AnimatedIcons.ellipsis_search,
                        progress: animation,
                        size: 100,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20.0),
            if (movieProvider.movies.isNotEmpty)
              Expanded(
                child: FutureBuilder(
                  future: FilmApi(dio).fetchMovies(searchController.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Movie> movies = snapshot.data ?? [];
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 2 / 4,
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(movie: movies[index]),
                                ),
                              );
                            },
                            child: MovieCard(movie: movies[index]),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Testpage(),
            ),
          );
        },
        child: const Icon(Icons.wifi),
      ),
    );
  }
}
