import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasicExamples extends StatefulWidget {
  const BasicExamples({super.key});

  @override
  State<BasicExamples> createState() => _BasicExamplesState();
}

class _BasicExamplesState extends State<BasicExamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030014),
      body: ListView(
        children: const [
          // Header
          Header(),
          SizedBox(height: 80),
          // Banner Section
          Banner(),
          // Features Section
          Features(),
          // Showcase Section
          Showcase(),
          // Footer
          SizedBox(height: 120),
          Footer(),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(
            color: Color(0xFF4D2F8C),
          ),
        ),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3C087E),
            const Color(0xFF3C087E).withValues(alpha: 0.0),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 120),
            Column(
              children: [
                TextTyperAnimation(
                  config: BaseTextAnimationConfig(
                    text: 'Ready to get started?',
                    textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                TextTyperAnimation(
                  config: BaseTextAnimationConfig(
                    text: 'Start your free trial today. No credit card required.',
                    textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: const Color(0xFFEFEDFD).withValues(alpha: 0.7),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                ZoomIn(
                  config: BaseAnimationConfig(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF4D2F8C),
                            ),
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF3C087E).withValues(alpha: 0.0),
                                const Color(0xFF3C087E),
                              ],
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            child: Text(
                              'Start free trial',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            Column(
              children: [
                Text(
                  '© 2025 Reflect. All rights reserved.',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFFEFEDFD).withValues(alpha: 0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        'Privacy Policy',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        'Terms of Service',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Showcase extends StatelessWidget {
  const Showcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 80),
          ZoomIn(
            config: BaseAnimationConfig(
              delay: 2.seconds,
              curves: Curves.bounceOut,
              duration: 1.seconds,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF4D2F8C),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFE59CFF).withValues(alpha: 0.0),
                          const Color(0xFFBA9CFF).withValues(alpha: 0.2),
                          const Color(0xFF9CB2FF).withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                    child: Text(
                      'Reflect AI',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextTyperAnimation(
            config: BaseTextAnimationConfig(
              text: 'Notes with an AI assistant',
              repeat: true,
              textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          FadeIn(
            config: BaseAnimationConfig(
              delay: 3.seconds,
              repeat: true,
              child: Text(
                'Reflect uses GPT-4 and Whisper from OpenAI to improve your writing,\norganize your thoughts, and act as your intellectual thought partner.',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFFEFEDFD).withValues(alpha: 0.7),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Image.asset(
            'assets/images/showcase.png',
          ),
          Transform.translate(
            offset: const Offset(0, -80),
            child: TextTyperAnimation(
              config: BaseTextAnimationConfig(
                duration: 2.seconds,
                repeat: true,
                text: 'What can you do with Reflect AI?',
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              ZoomIn(
                config: BaseAnimationConfig(
                  repeat: true,
                  child: ShowcaseCard(
                    title: 'Transcribe voice notes',
                    description: 'with human-level accuracy',
                    icon: 'assets/icons/transcribe.svg',
                  ),
                ),
              ),
              ZoomIn(
                config: BaseAnimationConfig(
                  repeat: true,
                  child: ShowcaseCard(
                    title: 'Generate article outlines',
                    description: 'from your scattered thoughts',
                    icon: 'assets/icons/generate.svg',
                  ),
                ),
              ),
              ZoomIn(
                config: BaseAnimationConfig(
                  repeat: true,
                  child: ShowcaseCard(
                    title: 'List key takeaways and action',
                    description: 'items from your meeting notes',
                    icon: 'assets/icons/list.svg',
                  ),
                ),
              ),
              ZoomIn(
                config: BaseAnimationConfig(
                  repeat: true,
                  child: ShowcaseCard(
                    title: 'Fix grammar, spelling,',
                    description: 'and improve your writing',
                    icon: 'assets/icons/fix.svg',
                  ),
                ),
              ),
              ZoomIn(
                config: BaseAnimationConfig(
                  repeat: true,
                  child: ShowcaseCard(
                    title: 'Save your own',
                    description: 'custom prompts',
                    icon: 'assets/icons/save.svg',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShowcaseCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  const ShowcaseCard({super.key, required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 48,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFEFEDFD).withValues(alpha: 0.6),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 20,
      runSpacing: 20,
      children: [
        ZoomIn(
          config: BaseAnimationConfig(
            useScrollForAnimation: true,
            duration: 1.seconds,
            child: const FeatureCard(
              title: 'Built for speed',
              description: 'Instantly sync your notes across devices',
              icon: 'assets/icons/speed.svg',
            ),
          ),
        ),
        const ZoomIn(
          config: BaseAnimationConfig(
            useScrollForAnimation: true,
            child: FeatureCard(
              title: 'Networked notes',
              description: 'Form a graph of ideas with backlinked notes',
              icon: 'assets/icons/network.svg',
            ),
          ),
        ),
        const ZoomIn(
          config: BaseAnimationConfig(
            useScrollForAnimation: true,
            child: FeatureCard(
              title: 'IOS App',
              description: 'Capture ideas on the go, online or offline',
              icon: 'assets/icons/ios.svg',
            ),
          ),
        ),
        const ZoomIn(
          config: BaseAnimationConfig(
            useScrollForAnimation: true,
            child: FeatureCard(
              title: 'End-to-end encryption',
              description: 'Only you can access your notes',
              icon: 'assets/icons/end-to-end.svg',
            ),
          ),
        ),
        const ZoomIn(
          config: BaseAnimationConfig(
            useScrollForAnimation: true,
            child: FeatureCard(
              title: 'Calendar integration',
              description: 'Keep track of meetings and agendas',
              icon: 'assets/icons/calendar.svg',
            ),
          ),
        ),
        const ZoomIn(
          config: BaseAnimationConfig(
            useScrollForAnimation: true,
            child: FeatureCard(
              title: 'Publishing',
              description: 'Share anything you write with one click',
              icon: 'assets/icons/publishing.svg',
            ),
          ),
        ),
        const ZoomIn(
          config: BaseAnimationConfig(
            useScrollForAnimation: true,
            child: FeatureCard(
              title: 'Instant capture',
              description: 'Save snippets from your browser and Kindle',
              icon: 'assets/icons/capture.svg',
            ),
          ),
        ),
        const ZoomIn(
          config: BaseAnimationConfig(
            useScrollForAnimation: true,
            child: FeatureCard(
              title: 'Frictionless search',
              description: 'Easily recall and index past notes and ideas',
              icon: 'assets/icons/search.svg',
            ),
          ),
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  const FeatureCard({super.key, required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icon,
            width: 48,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFEFEDFD).withValues(alpha: 0.6),
                ),
          ),
        ],
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ZoomIn(
            config: BaseAnimationConfig(
              delay: 2.seconds,
              curves: Curves.bounceOut,
              duration: 1.seconds,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF4D2F8C),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFE59CFF).withValues(alpha: 0.0),
                          const Color(0xFFBA9CFF).withValues(alpha: 0.2),
                          const Color(0xFF9CB2FF).withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ai.svg',
                          width: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'New: Our AI integration just landed',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextTyperAnimation(
            config: BaseTextAnimationConfig(
              text: 'Think better with Reflect',
              textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          FadeIn(
            config: BaseAnimationConfig(
              delay: 3.seconds,
              child: Text(
                'Never miss a note, idea or connection.',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFFEFEDFD).withValues(alpha: 0.7),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Image.asset(
            'assets/images/banner.png',
            height: 494,
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Reflect',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF4D2F8C),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF3C087E).withValues(alpha: 0.0),
                      const Color(0xFF3C087E),
                    ],
                  ),
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text(
                    'Start free trial',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
