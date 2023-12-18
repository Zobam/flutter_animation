import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedColorPalette extends StatefulWidget {
  const AnimatedColorPalette({super.key});

  @override
  State<AnimatedColorPalette> createState() => _AnimatedColorPaletteState();
}

class _AnimatedColorPaletteState extends State<AnimatedColorPalette> {
  List<Color> currentPalette = generateRandomPalette();
  double containerRadius = 100;
  double clickCount = 0;

  static List<Color> generateRandomPalette() {
    final random = Random();
    return List.generate(
      5,
      (_) => Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      ),
    );
  }

  void regeneratePalette() {
    setState(() {
      clickCount += 1;
      currentPalette = generateRandomPalette();
    });
    if (clickCount % 2 == 0) {
      setState(() {
        containerRadius = 50;
      });
    } else {
      setState(() {
        containerRadius = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Palette Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Color color in currentPalette)
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInCubic,
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(containerRadius),
                ),
              ),
            ElevatedButton(
              onPressed: regeneratePalette,
              child: const Text('Generate New Palette'),
            ),
          ],
        ),
      ),
    );
  }
}
