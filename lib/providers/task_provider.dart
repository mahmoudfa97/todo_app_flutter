import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  Future<void> fetchTasks() async {
    final box = await Hive.openBox<TaskModel>('tasks');
    _tasks = box.values.toList();
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    final box = await Hive.openBox<TaskModel>('tasks');
    await box.add(task);
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    final box = await Hive.openBox<TaskModel>('tasks');
    final index = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      await box.putAt(index, updatedTask);
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    final box = await Hive.openBox<TaskModel>('tasks');
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      await box.deleteAt(index);
      _tasks.removeAt(index);
      notifyListeners();
    }
  }
}