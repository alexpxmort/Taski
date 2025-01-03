import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/task_model.dart';
import '../../data/repositories/task_repository.dart';

// Repositório compartilhado
final taskRepositoryProvider = Provider((ref) => TaskRepository());

// Provider para gerenciar lista de tarefas
final taskListProvider =
    StateNotifierProvider<TaskListViewModel, List<TaskModel>>(
  (ref) => TaskListViewModel(ref.read(taskRepositoryProvider)),
);

// Provider para gerenciar uma única tarefa
final taskDetailProvider =
    StateNotifierProvider<TaskDetailViewModel, TaskModel?>(
  (ref) => TaskDetailViewModel(ref.read(taskRepositoryProvider)),
);

class TaskListViewModel extends StateNotifier<List<TaskModel>> {
  final TaskRepository _repository;

  TaskListViewModel(this._repository) : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = await _repository.getTasks();
  }

  Future<void> addTask(TaskModel task) async {
    await _repository.addTask(task);
    await loadTasks();
  }
}

class TaskDetailViewModel extends StateNotifier<TaskModel?> {
  final TaskRepository _repository;

  TaskDetailViewModel(this._repository) : super(null);

  Future<void> updateIsComplete(TaskModel task, bool isCompleted) async {
    await _repository.setIsComplete(task.id!, isCompleted);
    state = TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: isCompleted,
    );
  }
}
