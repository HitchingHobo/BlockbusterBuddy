import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: const TextStyle(
        fontSize: 18.0,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;

  const BodyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14.0, color: Colors.grey),
      overflow: TextOverflow.ellipsis,
    );
  }
}
