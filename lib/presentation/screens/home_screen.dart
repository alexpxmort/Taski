import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/presentation/screens/task_list.dart';
import 'package:taski/presentation/viewmodels/task_viewmodel.dart';
import 'package:taski/widgets/emptyTask.dart';
import 'package:taski/widgets/header.dart';
import 'package:taski/widgets/tasks_resume.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);
    print(tasks.length);

    return Scaffold(
      appBar: AppBar(title: HeaderWidget()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Welcome, ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3F3D56),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "John.",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              TaskResume(),
              tasks.isEmpty
                  ? EmptyTaskWidget()
                  : Expanded(child: TaskList(tasks: tasks))
            ],
          ),
        ),
      ),
    );
  }
}
