import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';

class TextExamples extends StatefulWidget {
  const TextExamples({super.key});

  @override
  State<TextExamples> createState() => _TextExamplesState();
}

class _TextExamplesState extends State<TextExamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: context.scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80),
          child: Column(
            children: [
              const SizedBox(height: 120),
              TextTyperAnimation(
                globalKey: GlobalKey(),
                repeat: true,
                duration: 4.seconds,
                text: 'Exploring the world of Flutter On Scroll Animation without fade effect',
                curves: Curves.easeInOut,
                textAlign: TextAlign.center,
                fade: false,
              ),
              const SizedBox(height: 80),
              TextTyperAnimation(
                globalKey: GlobalKey(),
                repeat: true,
                duration: 4.seconds,
                text: 'Exploring the world of Flutter On Scroll Animation with fade effect',
                curves: Curves.easeInOut,
                fade: true,
              ),
              const SizedBox(height: 80),
              TextTyperWavyAnimation(
                globalKey: GlobalKey(),
                repeat: true,
                duration: 4.seconds,
                text: 'Exploring the world of Flutter On Scroll Animation with wavy effect',
                curves: Curves.easeInOut,
              ),
              const SizedBox(height: 420),
            ],
          ),
        ),
      ),
    );
  }
}
