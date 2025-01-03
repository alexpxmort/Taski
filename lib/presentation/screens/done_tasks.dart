import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/presentation/screens/taskListCompleted.dart';
import 'package:taski/presentation/viewmodels/task_viewmodel.dart';
import 'package:taski/widgets/confirmation-dialog.dart';
import 'package:taski/widgets/header.dart';

class TasksDoneScreen extends ConsumerWidget {
  const TasksDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
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
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3F3D56)),
                    ),
                    GestureDetector(
                        onTap: () async {
                          final result = await ConfirmationDialog.show(
                            context,
                            title: 'Confirmação',
                            content:
                                'Tem certeza que deseja excluir todas as tarefas completadas?', // Texto ajustado
                            cancelText: 'Cancelar',
                            confirmText: 'Confirmar',
                            confirmButtonColor: Colors.red,
                          );

                          if (result == true) {
                            ref
                                .read(taskDetailProvider.notifier)
                                .deleteAllCompletedTasks();

                            ref.read(taskListProvider.notifier).loadTasks();
                          }
                        },
                        child: Text('Delete All',
                            style: TextStyle(
                              fontFamily: 'Urbanist',

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
