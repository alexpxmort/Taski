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

  Future<void> setIsComplete(int id, bool isCompleted) async {
    final db = await _dbHelper.database;

    await db.rawUpdate(
      '''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    ''',
      [isCompleted ? 1 : 0, id],
    );
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await _dbHelper.database;

    await db.rawUpdate(
      '''
    UPDATE tasks
    SET title = ?
    WHERE id = ?
    ''',
      [task.title, task.id],
    );
  }

  Future<void> deleteTaskById(int id) async {
    final db = await _dbHelper.database;

    await db.rawUpdate(
      '''
    DELETE FROM  tasks
    WHERE id = ?
    ''',
      [id],
    );
  }

  Future<void> deleteAllCompletedTasks() async {
    final db = await _dbHelper.database;

    await db.rawUpdate(
      '''
    DELETE FROM  tasks
    WHERE isCompleted = 1
    ''',
    );
  }
}
