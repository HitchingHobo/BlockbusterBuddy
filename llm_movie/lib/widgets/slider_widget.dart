import 'package:flutter/material.dart';
import 'package:llm_movie/utilities/movie_class.dart';

class SliderWidget extends StatelessWidget {
  final String title;
  final double sliderValue;
  final Function(double) onChanged;

  const SliderWidget({
    required this.title,
    required this.sliderValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: sliderValue,
          max: 10,
          divisions: 10,
          label: sliderValue.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
