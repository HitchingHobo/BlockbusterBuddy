import 'package:flutter/material.dart';
import 'package:llm_movie/widgets/formatting_widget.dart';

class Testpage extends StatelessWidget {
  const Testpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testpage'),
      ),
      body: const TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingText();
  }
}
