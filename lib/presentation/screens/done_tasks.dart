import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/presentation/screens/taskListCompleted.dart';
import 'package:taski/presentation/viewmodels/task_viewmodel.dart';
import 'package:taski/widgets/header.dart';

class TasksDoneScreen extends ConsumerWidget {
  const TasksDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(title: HeaderWidget()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Completed Tasks",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3F3D56)),
                    ),
                    GestureDetector(
                        child: Text('Delete All',
                            style: TextStyle(
                              color: Color(0xFFFF5E5E), // Cor do texto branco
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            )))
                  ],
                ),
              ),
              if (completedTasks.length > 0)
                Expanded(child: TaskListCompleted(tasks: completedTasks))
            ],
          ),
        ),
      ),
    );
  }
}
