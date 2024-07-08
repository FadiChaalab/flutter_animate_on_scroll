import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';

import '../components/custom_info.dart';

class RotateExamples extends StatelessWidget {
  const RotateExamples({super.key});

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
              RotateIn(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate In'),
              ),
              const SizedBox(height: 80),
              RotateInUpLeft(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate In Up Left'),
              ),
              const SizedBox(height: 80),
              RotateInUpRight(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate In Up Right'),
              ),
              const SizedBox(height: 80),
              RotateInDownLeft(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate In Down Left'),
              ),
              const SizedBox(height: 80),
              RotateInDownRight(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate In Down Right'),
              ),
              const SizedBox(height: 80),
              const Divider(),
              RotateOut(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate Out'),
              ),
              const SizedBox(height: 80),
              RotateOutDownLeft(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate Out Down Left'),
              ),
              const SizedBox(height: 80),
              RotateOutDownRight(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate Out Down Right'),
              ),
              const SizedBox(height: 80),
              RotateOutUpLeft(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate Out Up Left'),
              ),
              const SizedBox(height: 80),
              RotateOutUpRight(
                globalKey: GlobalKey(),
                duration: 1.seconds,
                repeat: true,
                child: const CustomInfo(name: 'Rotate Out Up Right'),
              ),
              const SizedBox(height: 420),
            ],
          ),
        ),
      ),
    );
  }
}
