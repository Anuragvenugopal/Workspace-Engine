import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import '../core/router/app_router.dart';
import 'profile_provider.dart';

/// Manages the splash screen animation sequence and navigation logic.
class SplashProvider extends ChangeNotifier implements TickerProvider {
  bool _navDone = false;

  late final AnimationController bgCtrl;
  late final AnimationController logoCtrl;
  late final AnimationController textCtrl;
  late final AnimationController taglineCtrl;
  late final AnimationController dotsCtrl;
  late final AnimationController bottomLoaderCtrl;

  late final Animation<double> bgOpacity;
  late final Animation<double> logoScale;
  late final Animation<double> logoOpacity;
  late final Animation<Offset> nameSlide;
  late final Animation<double> nameOpacity;
  late final Animation<double> taglineOpacity;
  late final Animation<Offset> pillsSlide;
  late final Animation<double> pillsOpacity;
  late final List<Animation<double>> bottomLoaderAnims;

  SplashProvider() {
    _initAnimations();
  }

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);

  void _initAnimations() {
    bgCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    bgOpacity = CurvedAnimation(parent: bgCtrl, curve: Curves.easeOut);

    logoCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: logoCtrl, curve: Curves.elasticOut));
    logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: logoCtrl, curve: const Interval(0.0, 0.45, curve: Curves.easeIn)));

    textCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    nameSlide = Tween<Offset>(begin: const Offset(0, 0.45), end: Offset.zero).animate(
        CurvedAnimation(parent: textCtrl, curve: Curves.easeOutCubic));
    nameOpacity = CurvedAnimation(parent: textCtrl, curve: Curves.easeIn);

    taglineCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    taglineOpacity = CurvedAnimation(parent: taglineCtrl, curve: Curves.easeIn);

    dotsCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    pillsSlide = Tween<Offset>(begin: const Offset(0, 0.6), end: Offset.zero).animate(
        CurvedAnimation(parent: dotsCtrl, curve: Curves.easeOutCubic));
    pillsOpacity = CurvedAnimation(parent: dotsCtrl, curve: Curves.easeIn);

    bottomLoaderCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();
    bottomLoaderAnims = List.generate(3, (i) {
      final start = i * 0.2;
      return Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: bottomLoaderCtrl,
          curve: Interval(start, start + 0.4, curve: Curves.easeInOut),
        ),
      );
    });
  }

  /// Runs the full animation sequence and navigates when complete.
  Future<void> runSequence(BuildContext context, ProfileProvider profileProvider) async {
    bgCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 100));
    logoCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    textCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 250));
    taglineCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    dotsCtrl.forward();

    // Wait for a minimum time so the splash doesn't disappear too quickly
    final minWait = Future.delayed(const Duration(milliseconds: 500));
    
    // Ensure the profile provider has finished loading local data
    if (profileProvider.state.isLoading) {
      await Future.any([
        _awaitReady(profileProvider),
        Future.delayed(const Duration(seconds: 4)), // safety timeout
      ]);
    }
    
    await minWait;

    // Navigate to dashboard
    if (context.mounted && !_navDone) {
      _navDone = true;
      context.go(AppRoutes.dashboard);
    }
  }

  Future<void> _awaitReady(ProfileProvider pp) async {
    while (pp.state.isLoading) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  void dispose() {
    bgCtrl.dispose();
    logoCtrl.dispose();
    textCtrl.dispose();
    taglineCtrl.dispose();
    dotsCtrl.dispose();
    bottomLoaderCtrl.dispose();
    super.dispose();
  }
}
