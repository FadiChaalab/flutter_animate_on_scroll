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
              RotateIn(
                globalKey: GlobalKey(),
                child: const CustomInfo(name: 'Rotate In'),
              ),
              const SizedBox(height: 20),
              RotateInUpLeft(
                globalKey: GlobalKey(),
                delay: 200.ms,
                child: const CustomInfo(name: 'Rotate In Up Left'),
              ),
              const SizedBox(height: 20),
              RotateInUpRight(
                globalKey: GlobalKey(),
                delay: 400.ms,
                child: const CustomInfo(name: 'Rotate In Up Right'),
              ),
              const SizedBox(height: 20),
              RotateInDownLeft(
                globalKey: GlobalKey(),
                delay: 600.ms,
                child: const CustomInfo(name: 'Rotate In Down Left'),
              ),
              const SizedBox(height: 20),
              RotateInDownRight(
                globalKey: GlobalKey(),
                delay: 200.ms,
                child: const CustomInfo(name: 'Rotate In Down Right'),
              ),
              const SizedBox(height: 20),
              const Divider(),
              RotateOut(
                globalKey: GlobalKey(),
                delay: 400.ms,
                child: const CustomInfo(name: 'Rotate Out'),
              ),
              const SizedBox(height: 20),
              RotateOutDownLeft(
                globalKey: GlobalKey(),
                delay: 600.ms,
                child: const CustomInfo(name: 'Rotate Out Down Left'),
              ),
              const SizedBox(height: 20),
              RotateOutDownRight(
                globalKey: GlobalKey(),
                delay: 800.ms,
                child: const CustomInfo(name: 'Rotate Out Down Right'),
              ),
              const SizedBox(height: 20),
              RotateOutUpLeft(
                globalKey: GlobalKey(),
                delay: 400.ms,
                child: const CustomInfo(name: 'Rotate Out Up Left'),
              ),
              const SizedBox(height: 20),
              RotateOutUpRight(
                globalKey: GlobalKey(),
                delay: 600.ms,
                child: const CustomInfo(name: 'Rotate Out Up Right'),
              ),
              const SizedBox(height: 220),
            ],
          ),
        ),
      ),
    );
  }
}
