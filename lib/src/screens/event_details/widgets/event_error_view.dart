import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';
import '../../../../providers/events_provider.dart';

class EventErrorView extends StatelessWidget {
  final String message;
  final int eventId;

  const EventErrorView({
    super.key,
    required this.message,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: context.h(48),
            color: AppColors.error,
          ),
          SizedBox(height: context.h(16)),
          AppText.body(message, color: AppColors.secondaryText),
          SizedBox(height: context.h(24)),
          FilledButton.icon(
            onPressed: () => context.read<EventsProvider>().loadEventById(eventId),
            icon: const Icon(Icons.refresh_rounded),
            label: const AppText('Retry', color: AppColors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
