import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive_size.dart';

class DashboardBanner extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final ProfileType? type;
  final Color activeColor;

  const DashboardBanner({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.type,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    double progress = totalTasks == 0 ? 0 : completedTasks / totalTasks;

    String title = 'Hurrah!';
    String subtitle = 'You are almost there';

    switch (type) {
      case ProfileType.work:
        title = 'On Track!';
        subtitle = 'Let\'s get things done';
        break;
      case ProfileType.corporate:
        title = 'Status Report';
        subtitle = 'Daily metrics overview';
        break;
      case ProfileType.creative:
        title = 'Inspiration!';
        subtitle = 'Fuel your creative process';
        break;
      case ProfileType.personal:
      default:
        break;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.w(24)),
      decoration: BoxDecoration(
        color: activeColor.withAlpha(15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: activeColor.withAlpha(30), width: 1.5),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                fontSize: context.h(24),
                fontWeight: FontWeight.bold,
                color: activeColor,
              ),
              SizedBox(height: context.h(4)),
              AppText(
                subtitle,
                fontSize: context.h(16),
                fontWeight: FontWeight.w600,
                color: activeColor,
              ),
              SizedBox(height: context.h(24)),
              AppText(
                '$completedTasks out of $totalTasks tasks are completed',
                fontSize: context.h(12),
                color: AppColors.black54,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: context.h(12)),
              Container(
                width: context.w(180),
                height: context.h(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -context.w(10),
            bottom: -context.h(10),
            child: Icon(
              type == ProfileType.creative
                  ? Icons.brush_rounded
                  : type == ProfileType.corporate
                      ? Icons.trending_up_rounded
                      : type == ProfileType.work
                          ? Icons.task_alt_rounded
                          : Icons.rocket_launch_rounded,
              size: context.h(100),
              color: activeColor.withAlpha(40),
            ),
          ),
        ],
      ),
    );
  }
}
