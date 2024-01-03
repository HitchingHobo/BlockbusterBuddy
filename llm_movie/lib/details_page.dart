import 'package:flutter/material.dart';
import 'package:llm_movie/utilities/movie_class.dart';
import 'package:llm_movie/widgets/slider_widget.dart';

class DetailsPage extends StatefulWidget {
  final Movie movie;

  DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double _storySliderValue = 8;
  double _cameraSliderValue = 5;
  double _castSliderValue = 3;

  List<bool> genreButtonState = [];
  List<bool> keywordButtonState = [];

  @override
  void initState() {
    super.initState();
    genreButtonState = List.filled(widget.movie.genres.length, false);
    keywordButtonState = List.filled(widget.movie.keywords.length, false);
  }

  Widget build(BuildContext context) {
    String releaseYear = widget.movie.releaseDate.substring(0, 4);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Text(
            'What did you think about ${widget.movie.title} ($releaseYear)',
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          SliderWidget(
            title: 'Story',
            sliderValue: _storySliderValue,
            onChanged: (double value) {
              setState(
                () {
                  _storySliderValue = value;
                },
              );
            },
          ),
          SliderWidget(
            title: 'Cinematography',
            sliderValue: _cameraSliderValue,
            onChanged: (double value) {
              setState(
                () {
                  _cameraSliderValue = value;
                },
              );
            },
          ),
          SliderWidget(
            title: 'Cast',
            sliderValue: _castSliderValue,
            onChanged: (double value) {
              setState(
                () {
                  _castSliderValue = value;
                },
              );
            },
          ),
          ToggleButtons(
            children: widget.movie.genres.map((genre) => Text(genre)).toList(),
            isSelected: genreButtonState,
            onPressed: (index) {
              setState(
                () {
                  genreButtonState[index] = !genreButtonState[index];
                },
              );
            },
          ),
          ToggleButtons(
            children:
                widget.movie.keywords.map((keyword) => Text(keyword)).toList(),
            isSelected: keywordButtonState,
            onPressed: (index) {
              setState(
                () {
                  keywordButtonState[index] = !keywordButtonState[index];
                },
              );
            },
          ),
// END OF CHILDREN/////////////////
        ],
      ),
    );
  }
}



 // body: ListView(
          //   padding: const EdgeInsets.all(12.0),
          //   children: [
          //     Text(movie.title),
          //     Text(movie.description),
          //     Text('Released in: ${movie.releaseDate}'),
          //     Text('Rating (0-10): ${movie.rating}'),
          //     Text('Tmdb id: ${movie.tmdbId}'),
          //     Text('Streaming info: ${movie.streamInfo.toString()}'),
          //     Text('Genres: ${movie.genres.toString()}'),
          //     Text('Keywords: ${movie.keywords.toString()}'),
          //     Text('Actors: ${movie.actors.toString()}'),
          //     Text('Director: ${movie.director.toString()}'),
          //     Image.network(movie.posterPath),
          //   ],
          // ),