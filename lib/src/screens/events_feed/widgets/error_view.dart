import 'package:flutter/material.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_rounded, size: context.h(64), color: AppColors.grey),
          SizedBox(height: context.h(16)),
          const AppText.subheading(
            'Failed to load events',
            color: AppColors.primaryText,
          ),
          SizedBox(height: context.h(8)),
          AppText.body(message, color: AppColors.grey),
          SizedBox(height: context.h(24)),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const AppText('Retry', color: AppColors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
