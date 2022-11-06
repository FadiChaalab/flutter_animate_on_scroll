import 'package:example/src/components/custom_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const MyHomePage(),
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
