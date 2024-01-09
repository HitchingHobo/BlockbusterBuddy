import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class DetailsFormat extends StatelessWidget {
  final List<Widget> children;

  const DetailsFormat({
    super.key,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}

class DetailsPosterFormat extends StatelessWidget {
  final String posterPath;
  final String title;
  final String releaseYear;

  const DetailsPosterFormat({
    super.key,
    required this.posterPath,
    required this.title,
    required this.releaseYear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(posterPath),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Rate this movie for a personalized recommendation.',
                    style: TextStyle(fontSize: 14.5),
                  ),
                ),
                Text(
                  'Use the sliders to score the movie and tap what aspects and actors from the movie you enjoyed most.',
                  style: TextStyle(fontSize: 14.5),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Finally if you want a similar movie in a different genre, tap the genre you're interested in.",
                    style: TextStyle(fontSize: 14.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingText extends StatelessWidget {
  const LoadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Paging BlockbusterBuddy...',
                      speed: const Duration(milliseconds: 200),
                    ),
                    TypewriterAnimatedText(
                      "Browsing old DVD's...",
                      speed: const Duration(milliseconds: 200),
                    ),
                    TypewriterAnimatedText(
                      'This could take a while...',
                      speed: const Duration(milliseconds: 200),
                    )
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
        const CircularProgressIndicator(),
        const SizedBox(
          height: 300.0,
          width: 100.0,
        )
      ],
    );
  }
}
