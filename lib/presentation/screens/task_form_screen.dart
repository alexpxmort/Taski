import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/presentation/viewmodels/task_viewmodel.dart';
import '../../data/database/task_model.dart';

class TaskFormScreen extends ConsumerWidget {
  final bool isModal;
  final bool isEdit;
  final TaskModel? task;

  const TaskFormScreen({
    Key? key,
    this.isModal = false,
    this.isEdit = false,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controlador recebe o título da tarefa, se for edição
    final controller = TextEditingController(text: isEdit ? task?.title : '');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo de texto
          TextField(
            maxLines: 4, // Permite várias linhas
            keyboardType: TextInputType.multiline,
            controller: controller,
            decoration: InputDecoration(
              hintText: isEdit ? 'Edit your note...' : 'Add a note...',
              hintStyle: const TextStyle(
                color: Color(0xFFC6CFDC),
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.edit,
                size: 20,
                color: Color(0xFFC6CFDC),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Botão "Create" ou "Save"
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (controller.text.isNotEmpty) {
                  if (isEdit && task != null) {
                    // Atualiza a tarefa existente
                    final updatedTask = task!.copyWith(
                      title: controller.text,
                    );
                    ref
                        .read(taskDetailProvider.notifier)
                        .updateTask(updatedTask);

                    ref.read(taskListProvider.notifier).loadTasks();

                    // Feedback visual para edição
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task updated successfully!'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  } else {
                    // Cria nova tarefa
                    final newTask = TaskModel(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: controller.text,
                      isCompleted: false,
                    );
                    ref.read(taskListProvider.notifier).addTask(newTask);

                    // Feedback visual para criação
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }

                  controller.clear();

                  if (isModal) {
                    Navigator.of(context).pop(); // Fecha o modal
                  }
                } else {
                  // Feedback para campos vazios
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task cannot be empty!'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              child: Text(
                isEdit ? 'Save' : 'Create',
                style: const TextStyle(
                  color: Color(0xFF0066FF),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
