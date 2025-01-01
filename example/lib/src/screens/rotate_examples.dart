import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';

import '../components/custom_info.dart';

class RotateExamples extends StatelessWidget {
  const RotateExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80),
          child: Column(
            children: [
              const SizedBox(height: 120),
              RotateIn(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate In'),
                ),
              ),
              const SizedBox(height: 80),
              RotateInUpLeft(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate In Up Left'),
                ),
              ),
              const SizedBox(height: 80),
              RotateInUpRight(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate In Up Right'),
                ),
              ),
              const SizedBox(height: 80),
              RotateInDownLeft(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate In Down Left'),
                ),
              ),
              const SizedBox(height: 80),
              RotateInDownRight(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate In Down Right'),
                ),
              ),
              const SizedBox(height: 80),
              const Divider(),
              RotateOut(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate Out'),
                ),
              ),
              const SizedBox(height: 80),
              RotateOutDownLeft(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate Out Down Left'),
                ),
              ),
              const SizedBox(height: 80),
              RotateOutDownRight(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate Out Down Right'),
                ),
              ),
              const SizedBox(height: 80),
              RotateOutUpLeft(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate Out Up Left'),
                ),
              ),
              const SizedBox(height: 80),
              RotateOutUpRight(
                config: BaseAnimationConfig(
                  duration: 1.seconds,
                  repeat: true,
                  child: const CustomInfo(name: 'Rotate Out Up Right'),
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
