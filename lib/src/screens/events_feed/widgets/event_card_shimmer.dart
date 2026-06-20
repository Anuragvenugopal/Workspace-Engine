import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

import '../../../../providers/profile_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../utils/responsive_size.dart';

class EventCardShimmer extends StatelessWidget {
  const EventCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final profileType = context.select<ProfileProvider, ProfileType>(
      (provider) => provider.state.activeProfile?.type ?? ProfileType.personal,
    );
    final color = AppTheme.getProfileColor(profileType);

    // Using the current theme's card color and background color
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(16), vertical: context.h(8)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: color.withAlpha(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.w(24)),
        ),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Placeholder
              Container(height: 200, width: double.infinity, color: Colors.white),
              // Content Placeholder
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w(20), vertical: context.h(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: context.h(24),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    ),
                    SizedBox(height: context.h(8)),
                    Container(
                      width: double.infinity,
                      height: context.h(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    ),
                    SizedBox(height: context.h(4)),
                    Container(
                      width: context.w(200),
                      height: context.h(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    ),
                    SizedBox(height: context.h(16)),
                    Row(
                      children: [
                        Container(
                          width: context.h(16),
                          height: context.h(16),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        ),
                        SizedBox(width: context.w(6)),
                        Container(
                          width: context.w(120),
                          height: context.h(14),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
