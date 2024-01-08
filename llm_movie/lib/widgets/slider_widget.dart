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

class YearRangeSlider extends StatelessWidget {
  final String title;
  final RangeValues yearRange;
  final Function(RangeValues) onChanged;

  const YearRangeSlider({
    Key? key,
    required this.title,
    required this.yearRange,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleText(
          text: '$title ${yearRange.start.round()} - ${yearRange.end.round()}',
        ),
        const SizedBox(height: 20),
        RangeSlider(
          values: yearRange,
          min: 1960,
          max: 2020,
          divisions:
              60, // Adjust the number of divisions based on your preference
          labels: RangeLabels(
            yearRange.start.round().toString(),
            yearRange.end.round().toString(),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
