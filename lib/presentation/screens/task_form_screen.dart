import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/presentation/viewmodels/task_viewmodel.dart';
import '../../data/database/task_model.dart';

class TaskFormScreen extends ConsumerWidget {
  const TaskFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: controller,
                decoration: const InputDecoration(
                    labelText: 'Add a note',
                    prefixIcon: Icon(
                      Icons.edit,
                      size: 20,
                      color: Color(0xFFC6CFDC),
                    ))),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                if (controller.text.isNotEmpty) {
                  final newTask = TaskModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: controller.text,
                    isCompleted: false,
                  );
                  ref.read(taskListProvider.notifier).addTask(newTask);
                  controller.text = '';
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task adicionada com Sucesso!'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task title cannot be empty!'),
                    ),
                  );
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
