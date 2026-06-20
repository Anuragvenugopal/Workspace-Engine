import 'package:flutter/material.dart';
import '../../../../features/profiles/domain/entities/profile.dart';

class TodoHeader extends StatelessWidget {
  final Profile? activeProfile;

  const TodoHeader({super.key, required this.activeProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${activeProfile?.name ?? ''} Tasks',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Text(
          'Manage your daily progress',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
