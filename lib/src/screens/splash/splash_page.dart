import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workspace_engine/src/screens/splash/widgets/app_name.dart';
import 'package:workspace_engine/src/screens/splash/widgets/bottom_loader.dart';
import 'package:workspace_engine/src/screens/splash/widgets/light_bg_painter.dart';
import 'package:workspace_engine/src/screens/splash/widgets/logo_card.dart';
import 'package:workspace_engine/src/screens/splash/widgets/profile_pills.dart';
import 'package:workspace_engine/src/screens/splash/widgets/soft_orb.dart';
import 'package:workspace_engine/src/screens/splash/widgets/tagline.dart';

import '../../../providers/profile_provider.dart';
import '../../../providers/splash_provider.dart';
import '../../../utils/app_colors.dart';

/// Branded splash screen — light/white style.
///
/// Logic and navigation sequence are managed by [SplashProvider].
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = SplashProvider();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
          provider.runSequence(context, context.read<ProfileProvider>());
        });
        return provider;
      },
      child: Builder(
        builder: (context) {
          final size = MediaQuery.sizeOf(context);
          final provider = context.read<SplashProvider>();

          // ── profile brand colours for orbs (loaded from AppColors) ──────────────────
          // sky blue – top-right orb (Personal)
          // violet – bottom-left orb (Creative)
          // emerald – mid-left orb (Work)
          final orbColors = [
            AppColors.personal,
            AppColors.creative,
            AppColors.work,
          ];

          return Scaffold(
            backgroundColor: Colors.white,
            body: FadeTransition(
              opacity: provider.bgOpacity,
              child: Stack(
                children: [
                  // 1. Painted background (white + faint gradient)
                  const Positioned.fill(
                    child: CustomPaint(painter: LightBgPainter()),
                  ),

                  // 2. Decorative soft orbs
                  Positioned(
                    top: -size.height * 0.06,
                    right: -size.width * 0.2,
                    child: SoftOrb(
                      color: orbColors[0],
                      size: size.width * 0.65,
                    ),
                  ),
                  Positioned(
                    bottom: -size.height * 0.05,
                    left: -size.width * 0.2,
                    child: SoftOrb(
                      color: orbColors[1],
                      size: size.width * 0.7,
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.38,
                    left: -size.width * 0.12,
                    child: SoftOrb(
                      color: orbColors[2],
                      size: size.width * 0.4,
                    ),
                  ),

                  // 3. Centre content column
                  SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo card
                          ScaleTransition(
                            scale: provider.logoScale,
                            child: FadeTransition(
                              opacity: provider.logoOpacity,
                              child: LogoCard(screenSize: size),
                            ),
                          ),

                          SizedBox(height: size.height * 0.038),

                          // App name (two-tone)
                          ClipRect(
                            child: SlideTransition(
                              position: provider.nameSlide,
                              child: FadeTransition(
                                opacity: provider.nameOpacity,
                                child: const AppName(),
                              ),
                            ),
                          ),

                          SizedBox(height: size.height * 0.01),

                          // Tagline
                          FadeTransition(
                            opacity: provider.taglineOpacity,
                            child: const Tagline(),
                          ),

                          SizedBox(height: size.height * 0.06),

                          // Profile pills
                          ClipRect(
                            child: SlideTransition(
                              position: provider.pillsSlide,
                              child: FadeTransition(
                                opacity: provider.pillsOpacity,
                                child: const ProfilePills(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 4. Animated loading dots at the bottom
                  Positioned(
                    bottom: 32,
                    left: 0,
                    right: 0,
                    child: FadeTransition(
                      opacity: provider.taglineOpacity,
                      child: const BottomLoader(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
