import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/responsive_size.dart';

class EventDetailShimmer extends StatelessWidget {
  final Color color;

  const EventDetailShimmer({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: color,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.w(20),
                    vertical: context.h(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.h(16)),
                      Container(height: context.h(28), width: context.w(200), color: Colors.white),
                      SizedBox(height: context.h(16)),
                      Container(
                        height: context.h(32),
                        width: context.w(150),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      SizedBox(height: context.h(24)),
                      const Divider(),
                      SizedBox(height: context.h(24)),
                      Container(height: context.h(20), width: context.w(120), color: Colors.white),
                      SizedBox(height: context.h(12)),
                      Container(height: context.h(16), width: double.infinity, color: Colors.white),
                      SizedBox(height: context.h(8)),
                      Container(height: context.h(16), width: double.infinity, color: Colors.white),
                      SizedBox(height: context.h(8)),
                      Container(height: context.h(16), width: context.w(250), color: Colors.white),
                      SizedBox(height: context.h(40)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
