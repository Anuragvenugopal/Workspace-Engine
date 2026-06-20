import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../features/events/domain/entities/global_event.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class EventCard extends StatelessWidget {
  final GlobalEvent event;
  final Color color;

  const EventCard({super.key, required this.event, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(16), vertical: context.h(8)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: color.withAlpha(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.w(24)),
          side: BorderSide(color: color.withAlpha(30), width: 1.5),
        ),
        child: InkWell(
          onTap: () => context.push('/events/${event.id}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: event.imageUrl, // Use full image for header
                httpHeaders: const {'User-Agent': 'Mozilla/5.0'},
                width: double.infinity,
                height: context.h(140),
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  return Shimmer.fromColors(
                    baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                    highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
                    child: Container(
                      height: context.h(140),
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                },
                errorWidget: (context, url, error) => Container(
                  height: context.h(140),
                  color: AppColors.border,
                  child: const Icon(Icons.broken_image_rounded,
                      color: AppColors.grey, size: 32),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.w(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                        fontSize: context.h(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.h(8)),
                    Text(
                      event.description,
                      style: TextStyle(
                        fontSize: context.h(14),
                        height: 1.4,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.h(12)),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded,
                            size: context.h(16), color: color),
                        SizedBox(width: context.w(6)),
                        Text(
                          DateFormat('MMMM dd, yyyy').format(event.eventDate),
                          style: TextStyle(
                              fontSize: context.h(13),
                              color: color,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Icon(Icons.arrow_forward_rounded,
                            size: context.h(20), color: color),
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
