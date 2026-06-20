import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';
import '../../../../features/events/domain/entities/global_event.dart';

class EventDetailView extends StatelessWidget {
  final GlobalEvent event;
  final Color color;

  const EventDetailView({
    super.key,
    required this.event,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          backgroundColor: color,
          iconTheme: const IconThemeData(color: AppColors.white),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: event.imageUrl,
                  httpHeaders: const {'User-Agent': 'Mozilla/5.0'},
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: color.withAlpha(51),
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: color.withAlpha(51),
                    child: Icon(
                      Icons.image_not_supported_rounded,
                      size: context.h(64),
                      color: AppColors.white,
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryText.withAlpha(127),
                        AppColors.transparent,
                        AppColors.primaryText.withAlpha(51),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                    AppText(
                      event.title,
                      fontSize: context.h(24),
                      fontWeight: FontWeight.bold,
                      color: AppColors.black87,
                    ),
                    SizedBox(height: context.h(16)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.w(12),
                        vertical: context.h(8),
                      ),
                      decoration: BoxDecoration(
                        color: color.withAlpha(26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.event_rounded, size: context.h(16), color: color),
                          SizedBox(width: context.w(6)),
                          AppText(
                            DateFormat('EEEE, MMM dd').format(event.eventDate),
                            fontSize: context.h(13),
                            color: color,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.h(24)),
                    const Divider(),
                    SizedBox(height: context.h(24)),
                    AppText(
                      'About this Event',
                      fontSize: context.h(18),
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                    SizedBox(height: context.h(12)),
                    AppText(
                      event.description,
                      fontSize: context.h(15),
                      color: AppColors.black87,
                    ),
                    SizedBox(height: context.h(40)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
