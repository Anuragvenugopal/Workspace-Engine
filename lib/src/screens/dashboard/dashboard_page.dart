import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/profile_provider.dart';
import '../../../utils/responsive_size.dart';
import '../../../features/profiles/domain/usecases/profile_usecases.dart';
import '../todo_manager/widgets/todo_list.dart';
import '../todo_manager/widgets/add_todo_sheet.dart';
import '../../../providers/todo_provider.dart';

import 'widgets/dashboard_drawer.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/dashboard_banner.dart';
import 'widgets/square_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final profileState = profileProvider.state;

        if (profileState.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final profiles = profileState.profiles;
        final getTodos = getIt<GetTodosForProfileUseCase>();
        
        int totalTasks = 0;
        int completedTasks = 0;

        final activeProfile = profileState.activeProfile;
        
        // Sync TodoProvider so the recent tasks list updates correctly
        if (activeProfile != null && context.read<TodoProvider>().currentProfileId != activeProfile.id) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<TodoProvider>().loadForProfile(activeProfile.id);
            }
          });
        }
        
        // Data for active profile card only
        if (activeProfile != null) {
          final todos = getTodos(activeProfile.id);
          completedTasks = todos.where((t) => t.isCompleted).length;
          totalTasks = todos.length;
        }

        final activeColor = activeProfile != null ? AppTheme.getProfileColor(activeProfile.type) : const Color(0xFF4A90E2);

        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F9),
          drawer: DashboardDrawer(
            profiles: profiles,
            activeProfile: activeProfile,
            activeColor: activeColor,
            profileProvider: profileProvider,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (context) => AddTodoSheet(color: activeColor),
              );
            },
            backgroundColor: activeColor,
            icon: const Icon(Icons.add_task_rounded, color: Colors.white),
            label: const Text('Add Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Static Header
                Padding(
                  padding: EdgeInsets.fromLTRB(context.w(16), context.h(20), context.w(24), 0),
                  child: DashboardHeader(activeProfile: activeProfile),
                ),
                
                SizedBox(height: context.h(20)),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Banner
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.w(24)),
                          child: DashboardBanner(
                            completedTasks: completedTasks,
                            totalTasks: totalTasks,
                            type: activeProfile?.type,
                            activeColor: activeColor,
                          ),
                        ),
                        SizedBox(height: context.h(24)),

                        // Quick Access Tiles
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.w(24)),
                          child: Text(
                            'Quick Access',
                            style: TextStyle(
                              fontSize: context.h(20),
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: context.h(12)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: context.w(24)),
                          child: Row(
                            children: [
                              SquareCard(
                                label: 'Global Events',
                                icon: Icons.event_rounded,
                                route: AppRoutes.events,
                                color: activeColor,
                              ),
                              SizedBox(width: context.w(16)),
                              SquareCard(
                                label: 'Calendar',
                                icon: Icons.calendar_month_rounded,
                                route: AppRoutes.calendar,
                                color: activeColor,
                              ),
                              SizedBox(width: context.w(16)),
                              SquareCard(
                                label: 'All Tasks',
                                icon: Icons.check_circle_outline_rounded,
                                route: AppRoutes.todos,
                                color: activeColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.h(30)),

                        // Recent Tasks Section
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.w(24)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Tasks',
                                style: TextStyle(
                                  fontSize: context.h(20),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.push(AppRoutes.todos),
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    color: activeColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.h(14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.h(4)),
                        
                        // Embedded TodoList (limit to 3 tasks to keep dashboard clean)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.w(8)), // TodoList already has some internal padding
                          child: TodoList(
                            color: activeColor,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            limit: 3,
                          ),
                        ),
                        
                        // Padding for FAB
                        SizedBox(height: context.h(80)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ); // closes Scaffold
      },
    );
  }
}
