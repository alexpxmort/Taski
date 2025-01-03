import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/presentation/viewmodels/task_viewmodel.dart';

class TaskResume extends ConsumerWidget {
  const TaskResume({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtém as tasks do provider
    final tasks = ref.watch(taskViewModelProvider);

    // Filtra as tarefas que não estão completas
    final incompleteTasks = tasks.where((task) => !task.isCompleted).toList();

    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 20),
      child: Text(
        "You’ve got ${incompleteTasks.length} tasks to do.",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF3F3D56),
        ),
      ),
    );
  }
}
