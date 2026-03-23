import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class StorageService {
  static const String _tasksKey = 'tasks_data';
  static const String _counterKey = 'counter_data';

  // --- Task Methods ---

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonTasks = tasks
        .map((task) => jsonEncode(task.toMap()))
        .toList();
    await prefs.setStringList(_tasksKey, jsonTasks);
  }

  Future<List<TaskModel>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonTasks = prefs.getStringList(_tasksKey);

    if (jsonTasks == null) return [];

    return jsonTasks.map((jsonStr) {
      return TaskModel.fromMap(jsonDecode(jsonStr));
    }).toList();
  }

  // --- Counter Methods ---

  Future<void> saveCounter(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_counterKey, value);
  }

  Future<int> getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_counterKey) ?? 0;
  }
}
