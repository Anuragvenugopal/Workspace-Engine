import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';

/// Pill chips showing the different profiles supported.
class ProfilePills extends StatelessWidget {
  const ProfilePills({super.key});

  static const _profiles = [
    (color: AppColors.corporate, label: 'Corporate'),
    (color: AppColors.work,      label: 'Work'),
    (color: AppColors.personal,  label: 'Personal'),
    (color: AppColors.creative,  label: 'Creative'),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _profiles
          .map(
            (p) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: p.color.withAlpha(40), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: p.color.withAlpha(20),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: p.color,
                      boxShadow: [
                        BoxShadow(
                          color: p.color.withAlpha(120),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    p.label,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: p.color,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
