import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

import 'providers/profile_provider.dart';


class WorkspaceEngineApp extends StatelessWidget {
  const WorkspaceEngineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final profileType =
            profileProvider.state.activeProfile?.type ?? ProfileType.personal;

        return MaterialApp.router(
          title: 'Workspace Engine',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getTheme(profileType),
          routerConfig: appRouter,
        );
      },
    );
  }
}
