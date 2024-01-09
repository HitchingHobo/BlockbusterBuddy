import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:llm_movie/results_page.dart';
import 'package:llm_movie/utilities/data_classes.dart';
import 'package:llm_movie/utilities/genre_id.dart';
import 'package:llm_movie/widgets/buttons.dart';
import 'package:llm_movie/widgets/formatting_widget.dart';
import 'package:llm_movie/widgets/slider_widget.dart';
import 'package:llm_movie/widgets/textstyles.dart';

class DetailsPage extends StatefulWidget {
  final Movie movie;

  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double _storySliderValue = 8;
  double _cameraSliderValue = 5;
  double _castSliderValue = 3;

  List<bool> genreButtonState = [];
  List<bool> keywordButtonState = [];
  List<bool> actorsButtonState = [];
  List<bool> tweakButtonState = [];

  @override
  void initState() {
    super.initState();
    genreButtonState = List.filled(widget.movie.genres.length, false);
    keywordButtonState = List.filled(widget.movie.keywords.length, false);
    actorsButtonState = List.filled(widget.movie.actors.length, false);
    tweakButtonState = List.filled(genreMap.length, false);
  }

  @override
  Widget build(BuildContext context) {
    String releaseYear = widget.movie.releaseDate.length >= 4
        ? widget.movie.releaseDate.substring(0, 4)
        : 'Release not found';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ratings page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Center(
            child: TitleText(
              text: '${widget.movie.title} ($releaseYear) ',
            ),
          ),
          DetailsPosterFormat(
            posterPath: widget.movie.posterPath,
            title: widget.movie.title,
            releaseYear: releaseYear,
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
            title: 'Directing',
            sliderValue: _castSliderValue,
            onChanged: (double value) {
              setState(
                () {
                  _castSliderValue = value;
                },
              );
            },
          ),
          DetailsFormat(children: [
            const TitleText(
              text: 'Genres',
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            ToggleButtonsWrap(
              title: 'genres',
              isSelected: genreButtonState,
              items: widget.movie.genres.cast<String>(),
              onPressed: (index) {
                setState(
                  () {
                    genreButtonState[index] = !genreButtonState[index];
                  },
                );
              },
            ),
          ]),
          DetailsFormat(children: [
            const TitleText(
              text: 'Keywords',
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            ToggleButtonsWrap(
              title: 'keywords',
              isSelected: keywordButtonState,
              items: widget.movie.keywords,
              onPressed: (index) {
                setState(
                  () {
                    keywordButtonState[index] = !keywordButtonState[index];
                  },
                );
              },
            ),
          ]),
          DetailsFormat(children: [
            const TitleText(
              text: 'Actors',
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            ToggleButtonsWrap(
              title: 'actors',
              isSelected: actorsButtonState,
              items: widget.movie.actors,
              onPressed: (index) {
                setState(
                  () {
                    actorsButtonState[index] = !actorsButtonState[index];
                  },
                );
              },
            ),
          ]),
          DetailsFormat(children: [
            const TitleText(
              text: 'What would you like to see more of?',
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            ToggleButtonsWrap(
              title: 'new genres',
              isSelected: tweakButtonState,
              items: widget.movie.tweakGenres.toList(),
              onPressed: (index) {
                setState(
                  () {
                    tweakButtonState[index] = !tweakButtonState[index];
                  },
                );
              },
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(85, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  elevation: 8),
              onPressed: () {
                List<String> selectedGenres = [];
                for (int i = 0; i < genreButtonState.length; i++) {
                  if (genreButtonState[i]) {
                    selectedGenres.add(widget.movie.genres[i]);
                  }
                }
                List<String> selectedKeywords = [];
                for (int i = 0; i < keywordButtonState.length; i++) {
                  if (keywordButtonState[i]) {
                    selectedKeywords.add(widget.movie.keywords[i]);
                  }
                }
                List<String> selectedActors = [];
                for (int i = 0; i < actorsButtonState.length; i++) {
                  if (actorsButtonState[i]) {
                    selectedActors.add(widget.movie.actors[i]);
                  }
                }
                List<String> selectedTweaks = [];
                for (int i = 0; i < tweakButtonState.length; i++) {
                  if (tweakButtonState[i]) {
                    selectedTweaks.add(widget.movie.tweakGenres[i]);
                  }
                }

                if (kDebugMode) {
                  print('Story Slider: $_storySliderValue');
                  print('Camera Slider: $_cameraSliderValue');
                  print('Cast Slider: $_castSliderValue');
                  print('Selected Genres: $selectedGenres');
                  print('Selected Keywords: $selectedKeywords');
                }
                Llmprompt prompt = Llmprompt(
                  title: widget.movie.title,
                  releaseYear: releaseYear,
                  story: _storySliderValue.toInt(),
                  cinematography: _cameraSliderValue.toInt(),
                  directing: _castSliderValue.toInt(),
                  genres: selectedGenres,
                  keywords: selectedKeywords,
                  actors: selectedActors,
                  tweakGenres: selectedTweaks,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Resultspage(prompt: prompt),
                  ),
                );
              },
              child: const Text(
                'Get your recommendations',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 20.0)
        ],
      ),
    );
  }
}
