import 'package:flutter/gestures.dart';

import './src/components/custom_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';

import 'src/screens/basic_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter On Scroll Animation Example',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const BasicExamples(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80),
          child: Column(
            children: [
              const SizedBox(height: 120),
              FadeIn(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Fade In'),
                ),
              ),
              const SizedBox(height: 120),
              SlideInDown(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Slide In Down'),
                ),
              ),
              const SizedBox(height: 80),
              RotateInUpLeft(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Rotate In Up Left'),
                ),
              ),
              const SizedBox(height: 80),
              FadeInLeft(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Fade In Left'),
                ),
              ),
              const SizedBox(height: 80),
              ZoomIn(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Zoom In'),
                ),
              ),
              const SizedBox(height: 80),
              TextTyperAnimation(
                config: BaseTextAnimationConfig(
                  repeat: true,
                  duration: 4.seconds,
                  text: 'Exploring the world of Flutter On Scroll Animation without fade effect',
                  curves: Curves.easeInOut,
                  textAlign: TextAlign.center,
                ),
                fade: false,
              ),
              const SizedBox(height: 80),
              TextTyperAnimation(
                config: BaseTextAnimationConfig(
                  repeat: true,
                  duration: 4.seconds,
                  text: 'Exploring the world of Flutter On Scroll Animation with fade effect',
                  curves: Curves.easeInOut,
                ),
                fade: true,
              ),
              const SizedBox(height: 80),
              TextTyperWavyAnimation(
                config: BaseTextAnimationConfig(
                  repeat: true,
                  duration: 4.seconds,
                  text: 'Exploring the world of Flutter On Scroll Animation with wavy effect',
                  curves: Curves.easeInOut,
                ),
              ),
              const SizedBox(height: 80),
              const Divider(),
              FadeOut(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Fade Out'),
                ),
              ),
              const SizedBox(height: 80),
              SlideOutUp(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Slide Out Up'),
                ),
              ),
              const SizedBox(height: 80),
              RotateOutDownLeft(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Rotate Out Down Left'),
                ),
              ),
              const SizedBox(height: 80),
              FadeOutLeft(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Fade Out Left'),
                ),
              ),
              const SizedBox(height: 80),
              ZoomOut(
                config: BaseAnimationConfig(
                  repeat: true,
                  duration: 1.seconds,
                  child: const CustomInfo(name: 'Zoom Out'),
                ),
              ),
              const SizedBox(height: 420),
            ],
          ),
        ),
      ),
    );
  }
}
