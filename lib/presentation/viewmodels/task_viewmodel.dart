import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/task_model.dart';
import '../../data/repositories/task_repository.dart';

final taskViewModelProvider =
    StateNotifierProvider<TaskViewModel, List<TaskModel>>(
  (ref) => TaskViewModel(),
);

class TaskViewModel extends StateNotifier<List<TaskModel>> {
  final TaskRepository _repository = TaskRepository();

  TaskViewModel() : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    state = await _repository.getTasks();
  }

  Future<void> addTask(TaskModel task) async {
    await _repository.addTask(task);
    _loadTasks();
  }

  Future<void> toggleTask(TaskModel task) async {
    // Atualize o estado local para refletir a mudança antes de salvar no repositório
    final updatedTasks = state.map((t) {
      if (t.id == task.id) {
        return t.copyWith(isCompleted: !t.isCompleted);
      }
      return t;
    }).toList();

    state = updatedTasks;

    // Salve a mudança no repositório
    await _repository.toggleTaskCompletion(task.id!);
  }
}
