import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_strings.dart';
import '../../core/settings/settings_controller.dart';
import '../../core/theme/app_theme.dart';
import '../home/home_screen.dart';
import 'onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await context.read<SettingsController>().setOnboardingSeen();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _next() {
    if (_currentPage == kOnboardingPages.length - 1) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: kOnboardingPages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, i) => _OnboardingPage(data: kOnboardingPages[i], onNext: _next),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.brand,
                        style: const TextStyle(
                          color: kWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        strings.tagline,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _finish,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black.withValues(alpha: 0.35),
                      foregroundColor: kWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(strings.skip),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data, required this.onNext});

  final OnboardingPageData data;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final strings = AppStrings.of(context);
    final index = kOnboardingPages.indexOf(data);
    final isLast = index == kOnboardingPages.length - 1;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(data.imageAsset, fit: BoxFit.cover),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.15),
                Colors.black.withValues(alpha: 0.55),
                Colors.black.withValues(alpha: 0.92),
              ],
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: kGold, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      data.eyebrow(languageCode),
                      style: const TextStyle(
                        color: kGold,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  data.title(languageCode),
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  data.desc(languageCode),
                  style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      '${kOnboardingPages.length} / ${index + 1}',
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    ..._buildDashes(index),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onNext,
                    icon: Icon(nextIcon(context), size: 18),
                    label: Text(isLast ? strings.getStarted : strings.next),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDashes(int activeIndex) {
    return List.generate(kOnboardingPages.length, (i) {
      final active = i == activeIndex;
      return Padding(
        padding: const EdgeInsetsDirectional.only(end: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: active ? 22 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? kGold : Colors.white38,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      );
    });
  }
}
