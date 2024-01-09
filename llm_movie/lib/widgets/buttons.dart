import 'package:flutter/material.dart';
import 'package:llm_movie/widgets/textstyles.dart';

class ToggleButtonsWrap extends StatefulWidget {
  final String title;
  final List<bool> isSelected;
  final List<String> items;
  final ValueChanged<int> onPressed;

  const ToggleButtonsWrap({
    super.key,
    required this.title,
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
    String title = widget.title;
    if (widget.items.isEmpty) {
      return SubtitleText(text: 'No $title found');
    }
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

  const ToggleButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            color: isSelected ? Colors.blue : Colors.white,
            width: 2.0,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        ),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
        ),
      ),
      child: Text(text.capitalizeFirstLetter()),
    );
  }
}
