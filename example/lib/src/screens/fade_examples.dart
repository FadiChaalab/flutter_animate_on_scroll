import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';

import '../components/custom_info.dart';

class FadeExamples extends StatefulWidget {
  const FadeExamples({super.key});

  @override
  State<FadeExamples> createState() => _FadeExamplesState();
}

class _FadeExamplesState extends State<FadeExamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80),
          child: Column(
            children: [
              const FadeIn(
                config: BaseAnimationConfig(
                  child: CustomInfo(name: 'Fade In'),
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                config: BaseAnimationConfig(
                  delay: 200.ms,
                  child: const CustomInfo(name: 'Fade In Down'),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                config: BaseAnimationConfig(
                  delay: 400.ms,
                  child: const CustomInfo(name: 'Fade In Up'),
                ),
              ),
              const SizedBox(height: 20),
              FadeInLeft(
                config: BaseAnimationConfig(
                  delay: 600.ms,
                  child: const CustomInfo(name: 'Fade In Left'),
                ),
              ),
              const SizedBox(height: 20),
              FadeInRight(
                config: BaseAnimationConfig(
                  delay: 800.ms,
                  child: const CustomInfo(name: 'Fade In Right'),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              FadeOut(
                config: BaseAnimationConfig(
                  delay: 200.ms,
                  child: const CustomInfo(name: 'Fade Out'),
                ),
              ),
              const SizedBox(height: 20),
              FadeOutUp(
                config: BaseAnimationConfig(
                  delay: 400.ms,
                  child: const CustomInfo(name: 'Fade Out Up'),
                ),
              ),
              const SizedBox(height: 20),
              FadeOutDown(
                config: BaseAnimationConfig(
                  delay: 600.ms,
                  child: const CustomInfo(name: 'Fade Out Down'),
                ),
              ),
              const SizedBox(height: 20),
              FadeOutLeft(
                config: BaseAnimationConfig(
                  delay: 800.ms,
                  child: const CustomInfo(name: 'Fade Out Left'),
                ),
              ),
              const SizedBox(height: 20),
              FadeOutRight(
                config: BaseAnimationConfig(
                  delay: 1000.ms,
                  child: const CustomInfo(name: 'Fade Out Right'),
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
