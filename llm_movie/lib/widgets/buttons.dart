import 'package:flutter/material.dart';
import 'package:llm_movie/utilities/genre_id.dart';
import 'package:llm_movie/widgets/textstyles.dart';

class ToggleButtonsWrap extends StatefulWidget {
  final List<bool> isSelected;
  final List<String> items;
  final ValueChanged<int> onPressed;

  const ToggleButtonsWrap({
    super.key,
    required this.isSelected,
    required this.items,
    required this.onPressed,
  });

  @override
  ToggleButtonsWrapState createState() => ToggleButtonsWrapState();
}

class ToggleButtonsWrapState extends State<ToggleButtonsWrap> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: List.generate(
        widget.items.length,
        (index) => ToggleButton(
          isSelected: widget.isSelected[index],
          onPressed: () => widget.onPressed(index),
          text: widget.items[index],
        ),
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;
  final String text;

  ToggleButton({
    required this.isSelected,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isSelected ? Colors.blue : Colors.grey,
        ),
      ),
      child: Text(text.capitalizeFirstLetter()),
    );
  }
}
