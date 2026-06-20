import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../utils/responsive_size.dart';

class ProfileLabel extends StatelessWidget {
  final ProfileType profileType;

  const ProfileLabel({
    super.key,
    required this.profileType,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_getLabel(profileType)} Calendar',
      style: TextStyle(
        fontSize: context.h(22),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  String _getLabel(ProfileType type) {
    switch (type) {
      case ProfileType.corporate:
        return 'Corporate';
      case ProfileType.creative:
        return 'Creative';
      case ProfileType.personal:
        return 'Personal';
      case ProfileType.work:
        return 'Work';
    }
  }
}
