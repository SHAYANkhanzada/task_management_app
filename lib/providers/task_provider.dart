import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/storage_service.dart';
import 'dart:math';

class TaskProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<TaskModel> _tasks = [];
  bool _isLoading = false;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();
    
    _tasks = await _storageService.getTasks();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;

    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(100).toString(),
      title: title.trim(),
    );

    _tasks.add(newTask);
    await _storageService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    await _storageService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      await _storageService.saveTasks(_tasks);
      notifyListeners();
    }
  }
}
