import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/data/database/task_model.dart';
import 'package:taski/presentation/screens/task_form_screen.dart';
import 'package:taski/presentation/viewmodels/task_viewmodel.dart';
import 'package:taski/widgets/confirmation-dialog.dart';

class TaskList extends ConsumerWidget {
  final List<TaskModel>
      tasks; // Propriedade 'tasks' para armazenar a lista de tarefas

  const TaskList(
      {super.key,
      required this.tasks}); // Recebe a lista de tarefas como parâmetro

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showEditTaskModal(BuildContext context, TaskModel task) {
      showModalBottomSheet(
        context: context,
        isScrollControlled:
            true, // Allows the modal to use full height if needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              height: 400,
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {
                          // Handle checkbox state change
                        },
                      ),
                      Text(
                        "What's in your mind?",
                        style: TextStyle(
                            color: Color(0xFFC6CFDC),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: TaskFormScreen(
                        isModal: true,
                        isEdit: true,
                        task: task,
                      )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    void showOptionsModal(BuildContext context, TaskModel task) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Opção Editar
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.blue),
                  title: const Text(
                    'Editar',
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    showEditTaskModal(context, task);
                  },
                ),
                const Divider(),
                // Opção Deletar
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    'Deletar',
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () async {
                    // Lógica para deletar

                    final result = await ConfirmationDialog.show(
                      context,
                      title: 'Confirmação',
                      item: task.title,
                      content:
                          'Tem certeza que deseja excluir esta tarefa?', // Texto ajustado
                      cancelText: 'Cancelar',
                      confirmText: 'Confirmar',
                      confirmButtonColor: Colors.red,
                    );

                    if (result == true) {
                      ref
                          .read(taskDetailProvider.notifier)
                          .deleteTaskById(task);

                      ref.read(taskListProvider.notifier).loadTasks();
                    }

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length, // Conta a quantidade de tarefas
        itemBuilder: (context, index) {
          final task = tasks[index];
          final ValueNotifier<bool> isCompleted =
              ValueNotifier(task.isCompleted);

          return ValueListenableBuilder<bool>(
            valueListenable: isCompleted,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.only(
                    bottom: 30.0), // Espaço entre os itens
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  tileColor:
                      Color(0xFFF5F7F9), // Cor de fundo para cada item da lista
                  title: Row(
                    children: [
                      Checkbox(
                        value: value,
                        onChanged: (bool? newValue) {
                          isCompleted.value = newValue ??
                              false; // Atualiza o estado do checkbox
                          ref
                              .read(taskDetailProvider.notifier)
                              .updateIsComplete(task, isCompleted.value);

                          ref.read(taskListProvider.notifier).loadTasks();
                        },
                      ),
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            color: Color(
                                0xFF3F3D56), // Cor do texto para melhor contraste
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert,
                        color: Color(0xFFC6CFDC)), // Ícone na cor branca
                    onPressed: () {
                      showOptionsModal(context, task);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
