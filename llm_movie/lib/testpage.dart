import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Testpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testpage'),
      ),
      body: LoadingText(),
    );
  }
}

class LoadingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 30.0,
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
        const CircularProgressIndicator(),
        const SizedBox(
          height: 300.0,
          width: 100.0,
        )
      ],
    );
  }
}
