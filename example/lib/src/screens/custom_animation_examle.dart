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
