import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/todo_provider.dart';
import '../../../../utils/responsive_size.dart';
import 'empty_todos.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  final Color color;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final int? limit;

  const TodoList({
    super.key,
    required this.color,
    this.physics,
    this.shrinkWrap = false,
    this.limit,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final state = todoProvider.state;
        if (state is TodoInitial || state is TodoLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TodoError) {
          return Center(child: Text(state.message));
        }
        if (state is TodoLoaded) {
          if (state.todos.isEmpty) {
            return EmptyTodos(color: color);
          }

          final displayTodos = limit != null ? state.todos.take(limit!).toList() : state.todos;

          return ListView.separated(
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: EdgeInsets.symmetric(horizontal: context.w(16), vertical: context.h(8)),
            itemCount: displayTodos.length,
            separatorBuilder: (_, __) => SizedBox(height: context.h(6)),
            itemBuilder: (context, index) =>
                TodoItem(todo: state.todos[index], color: color),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
