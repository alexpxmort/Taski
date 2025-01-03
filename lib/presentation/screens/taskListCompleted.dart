import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/data/database/task_model.dart';
import 'package:taski/presentation/viewmodels/task_viewmodel.dart';
import 'package:taski/widgets/confirmation-dialog.dart';

class TaskListCompleted extends ConsumerWidget {
  final List<TaskModel>
      tasks; // Propriedade 'tasks' para armazenar a lista de tarefas

  const TaskListCompleted({
    super.key,
    required this.tasks,
  }); // Recebe a lista de tarefas como parâmetro

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length, // Conta a quantidade de tarefas
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Padding(
            padding:
                const EdgeInsets.only(bottom: 30.0), // Espaço entre os itens
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              tileColor: const Color(
                  0xFFF5F7F9), // Cor de fundo para cada item da lista
              title: Row(
                children: [
                  const Icon(
                    Icons.check_box,
                    color: Color(0xFF8D9CB8), // Ícone de checkbox marcado
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(
                            0xFF3F3D56), // Cor do texto para melhor contraste
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Color(0xFFFF5E5E), // Cor do ícone de lixeira
                    ),
                    onPressed: () async {
                      final bool? confirmed =
                          await _showConfirmationDeleteTaskModal(
                              context, task, ref);
                      if (confirmed == true) {
                        // Ação de exclusão
                        print('Task excluída: ${task.title}');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool?> _showConfirmationDeleteTaskModal(
      BuildContext context, TaskModel task, WidgetRef ref) async {
    final result = await ConfirmationDialog.show(
      context,
      title: 'Confirmação',
      item: task.title,
      content: 'Tem certeza que deseja excluir esta tarefa?', // Texto ajustado
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      confirmButtonColor: Colors.red,
    );

    if (result == true) {
      ref.read(taskDetailProvider.notifier).deleteTaskById(task);

      ref.read(taskListProvider.notifier).loadTasks();
    }
  }
}
