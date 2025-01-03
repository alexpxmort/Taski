import 'package:flutter_test/flutter_test.dart';
import 'package:taski/data/database/task_model.dart';

void main() {
  group('TaskModel', () {
    // Test 1: Testing the toJson method
    test('should convert TaskModel to JSON correctly', () {
      final task = TaskModel(id: 1, title: 'Test Task', isCompleted: true);

      final json = task.toJson();

      expect(json['id'], 1);
      expect(json['title'], 'Test Task');
      expect(json['isCompleted'], 1); // isCompleted should be 1 for true
    });

    // Test 2: Testing the fromJson factory constructor
    test('should create TaskModel from JSON correctly', () {
      final json = {
        'id': 1,
        'title': 'Test Task',
        'isCompleted': 1,
      };

      final task = TaskModel.fromJson(json);

      expect(task.id, 1);
      expect(task.title, 'Test Task');
      expect(
          task.isCompleted, true); // isCompleted should be true when value is 1
    });

    // Test 3: Testing the copyWith method
    test('should create a new TaskModel instance with updated values', () {
      final task = TaskModel(id: 1, title: 'Test Task', isCompleted: false);

      final updatedTask =
          task.copyWith(title: 'Updated Task', isCompleted: true);

      expect(updatedTask.id, 1); // id should remain the same
      expect(updatedTask.title, 'Updated Task');
      expect(updatedTask.isCompleted, true);
    });

    // Test 4: Testing copyWith when no arguments are passed
    test('copyWith should not change values when no arguments are passed', () {
      final task = TaskModel(id: 1, title: 'Test Task', isCompleted: false);

      final updatedTask = task.copyWith();

      expect(updatedTask.id, task.id);
      expect(updatedTask.title, task.title);
      expect(updatedTask.isCompleted, task.isCompleted);
    });
  });
}
