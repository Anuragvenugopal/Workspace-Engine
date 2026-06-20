import 'package:flutter/material.dart';
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
          const Text('Failed to load events',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: context.h(8)),
          Text(message, style: const TextStyle(color: AppColors.grey)),
          SizedBox(height: context.h(24)),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
