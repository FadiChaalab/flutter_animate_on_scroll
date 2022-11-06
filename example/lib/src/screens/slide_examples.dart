import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';

import '../components/custom_info.dart';

class SlideExamples extends StatelessWidget {
  const SlideExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: context.scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80),
          child: Column(
            children: [
              SlideInDown(
                globalKey: GlobalKey(),
                delay: 200.ms,
                child: const CustomInfo(name: 'Slide In Down'),
              ),
              const SizedBox(height: 20),
              SlideInUp(
                globalKey: GlobalKey(),
                delay: 400.ms,
                child: const CustomInfo(name: 'Slide In Up'),
              ),
              const SizedBox(height: 20),
              SlideInLeft(
                globalKey: GlobalKey(),
                delay: 600.ms,
                child: const CustomInfo(name: 'Slide In Left'),
              ),
              const SizedBox(height: 20),
              SlideInRight(
                globalKey: GlobalKey(),
                delay: 200.ms,
                child: const CustomInfo(name: 'Slide In Right'),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              SlideOutUp(
                globalKey: GlobalKey(),
                delay: 600.ms,
                child: const CustomInfo(name: 'Slide Out Up'),
              ),
              const SizedBox(height: 20),
              SlideOutLeft(
                globalKey: GlobalKey(),
                delay: 400.ms,
                child: const CustomInfo(name: 'Slide Out Left'),
              ),
              const SizedBox(height: 20),
              SlideOutRight(
                globalKey: GlobalKey(),
                delay: 600.ms,
                child: const CustomInfo(name: 'Slide Out Right'),
              ),
              const SizedBox(height: 20),
              SlideOutDown(
                globalKey: GlobalKey(),
                delay: 800.ms,
                child: const CustomInfo(name: 'Slide Out Down'),
              ),
              const SizedBox(height: 420),
            ],
          ),
        ),
      ),
    );
  }
}
