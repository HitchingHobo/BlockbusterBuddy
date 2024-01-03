import 'package:flutter/material.dart';
import 'package:llm_movie/widgets/textstyles.dart';

class SliderWidget extends StatelessWidget {
  final String title;
  final double sliderValue;
  final Function(double) onChanged;

  const SliderWidget({
    super.key,
    required this.title,
    required this.sliderValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText(text: title),
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
