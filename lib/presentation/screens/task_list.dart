import 'package:flutter/material.dart';
import 'package:taski/data/database/task_model.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel>
      tasks; // Propriedade 'tasks' para armazenar a lista de tarefas

  const TaskList(
      {super.key,
      required this.tasks}); // Recebe a lista de tarefas como parâmetro

  @override
  Widget build(BuildContext context) {
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
                        },
                      ),
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
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
                    onPressed: () {},
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
