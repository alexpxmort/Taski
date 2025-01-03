import 'package:flutter/material.dart';
import 'package:taski/data/database/task_model.dart';

class TaskListCompleted extends StatelessWidget {
  final List<TaskModel>
      tasks; // Propriedade 'tasks' para armazenar a lista de tarefas

  const TaskListCompleted(
      {super.key,
      required this.tasks}); // Recebe a lista de tarefas como parâmetro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length, // Conta a quantidade de tarefas
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Padding(
            padding:
                const EdgeInsets.only(bottom: 30.0), // Espaço entre os itens
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              tileColor:
                  Color(0xFFF5F7F9), // Cor de fundo para cada item da lista
              title: Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.check_box,
                    color: Color(0xFF8D9CB8), // Ícone de checkbox marcado
                  ),
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(
                            0xFF8D9CB8), // Cor do texto para melhor contraste
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color(0xFFFF5E5E), // Cor do ícone de lixeira
                    ),
                    onPressed: () {
                      // Ação de exclusão (implementar conforme necessário)
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
}
