import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class TitleText extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;

  const TitleText({super.key, required this.text, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;

  const SubtitleText({super.key, required this.text, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18.0,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;

  const BodyText({super.key, required this.text, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16.0, color: Colors.grey),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
