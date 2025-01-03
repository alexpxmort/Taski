import '../database/database_helper.dart';
import '../database/task_model.dart';

class TaskRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<TaskModel>> getTasks() async {
    final db = await _dbHelper.database;
    final result = await db.query('tasks');
    return result.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<void> addTask(TaskModel task) async {
    final db = await _dbHelper.database;
    await db.insert('tasks', task.toJson());
  }

  Future<void> toggleTaskCompletion(int id) async {
    final db = await _dbHelper.database;
    await db.rawUpdate('''
      UPDATE tasks
      SET isCompleted = NOT isCompleted
      WHERE id = ?
    ''', [id]);
  }
}
