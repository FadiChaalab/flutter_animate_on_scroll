# Flutter_animate_on_scroll
Enables you to create flutter animations on scroll, faster, efficient and with less code.

## Features

- Stunning default animation
- Customizable animation

## Getting started

**Note:** Make sure to use [SingleChildScrollView] and attach [context.scrollController] to your controller

Put the dependency inside your pubspec.yml and run packages get.

## Usage

Provide required [GlobaleKey] and child [Widget], you can play with animation delay, curves, duration...

```dart
import './src/components/custom_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';

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
        controller: context.scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80),
          child: Column(
            children: [
              FadeIn(
                globalKey: GlobalKey(),
                child: const CustomInfo(name: 'Fade In'),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                globalKey: GlobalKey(),
                delay: 200.ms,
                child: const CustomInfo(name: 'Fade In Down'),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                globalKey: GlobalKey(),
                delay: 400.ms,
                child: const CustomInfo(name: 'Fade In Up'),
              ),
              const SizedBox(height: 20),
              FadeInLeft(
                globalKey: GlobalKey(),
                delay: 600.ms,
                child: const CustomInfo(name: 'Fade In Left'),
              ),
              const SizedBox(height: 20),
              FadeInRight(
                globalKey: GlobalKey(),
                delay: 200.ms,
                child: const CustomInfo(name: 'Fade In Right'),
              ),
              const SizedBox(height: 20),
              const Divider(),
              FadeOut(
                globalKey: GlobalKey(),
                delay: 400.ms,
                child: const CustomInfo(name: 'Fade Out'),
              ),
              const SizedBox(height: 20),
              FadeOutUp(
                globalKey: GlobalKey(),
                delay: 600.ms,
                child: const CustomInfo(name: 'Fade Out Up'),
              ),
              const SizedBox(height: 20),
              FadeOutDown(
                globalKey: GlobalKey(),
                delay: 800.ms,
                child: const CustomInfo(name: 'Fade Out Down'),
              ),
              const SizedBox(height: 20),
              FadeOutLeft(
                globalKey: GlobalKey(),
                delay: 400.ms,
                child: const CustomInfo(name: 'Fade Out Left'),
              ),
              const SizedBox(height: 20),
              FadeOutRight(
                globalKey: GlobalKey(),
                delay: 600.ms,
                child: const CustomInfo(name: 'Fade Out Right'),
              ),
              const SizedBox(height: 220),
            ],
          ),
        ),
      ),
    );
  }
}

```

#### Custom animation

```dart
import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';

import '../components/custom_info.dart';

class CustomAnimationExample extends StatefulWidget {
  const CustomAnimationExample({super.key});

  @override
  State<CustomAnimationExample> createState() => _CustomAnimationExampleState();
}

class _CustomAnimationExampleState extends State<CustomAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: 600.ms);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: context.scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80),
          child: Column(
            children: [
              CustomAnimated(
                animationController: _animationController,
                animation: _animation,
                globalKey: GlobalKey(),
                child: ScaleTransition(
                  scale: _animation,
                  child: const CustomInfo(name: 'Custom Animation'),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 220),
            ],
          ),
        ),
      ),
    );
  }
}

```

## Video Demo

<video width="320" height="240" controls>
  <source src="https://raw.githubusercontent.com/FadiChaalab/flutter_animate_on_scroll/main/assets/nft-example.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>


## Default Animations

### Fade Animation

![Fade Animation](https://github.com/FadiChaalab/flutter_animate_on_scroll/blob/main/animations/fade.gif)
- FadeIn
- FadeInDown
- FadeInLeft
- FadeInRight
- FadeInUp
- FadeOut
- FadeOutDown
- FadeOutLeft
- FadeOutRight
- FadeOutUp

### Slide Animation

![Slide Animation](https://github.com/FadiChaalab/flutter_animate_on_scroll/blob/main/animations/slide.gif)
- SlideInDown
- SlideInLeft
- SlideInRight
- SlideInUp
- SlideOutDown
- SlideOutLeft
- SlideOutRight
- SlideOutUp

### Rotate Animation

![Rotate Animation](https://github.com/FadiChaalab/flutter_animate_on_scroll/blob/main/animations/rotate.gif)
- RotateIn
- RotateInDownLeft
- RotateInDownRight
- RotateInUpLeft
- RotateInUpRight
- RotateOut
- RotateOutDownLeft
- RotateOutDownRight
- RotateOutUpLeft
- RotateOutUpRight

### Zoom Animation

- ZoomIn
- ZoomOut

### Text Animation

- Text typer animation with fade option
- Text wavy effect
