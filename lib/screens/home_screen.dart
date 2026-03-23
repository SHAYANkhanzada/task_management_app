import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/storage_service.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService _storageService = StorageService();
  int _selectedIndex = 0;

  // Task List Data
  List<TaskModel> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  // Counter Data
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final tasks = await _storageService.getTasks();
    final counter = await _storageService.getCounter();
    setState(() {
      _tasks = tasks;
      _counter = counter;
    });
  }

  // --- Task Methods ---

  void _addTask() {
    if (_taskController.text.trim().isEmpty) return;

    final newTask = TaskModel(
      id:
          DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(100).toString(),
      title: _taskController.text.trim(),
    );

    setState(() {
      _tasks.add(newTask);
    });
    _storageService.saveTasks(_tasks);
    _taskController.clear();
    Navigator.pop(context); // Close the bottom sheet or dialog
  }

  void _deleteTask(String id) {
    setState(() {
      _tasks.removeWhere((task) => task.id == id);
    });
    _storageService.saveTasks(_tasks);
  }

  void _toggleTaskCompletion(String id) {
    setState(() {
      final index = _tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        _tasks[index].isCompleted = !_tasks[index].isCompleted;
      }
    });
    _storageService.saveTasks(_tasks);
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Add New Task'),
          content: TextField(
            controller: _taskController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter task description...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _taskController.clear();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // --- Counter Methods ---

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _storageService.saveCounter(_counter);
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
    _storageService.saveCounter(_counter);
  }

  // --- UI Build ---

  Widget _buildTaskTab() {
    return _tasks.isEmpty
        ? const Center(
            child: Text(
              'No tasks yet. Add one!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              final task = _tasks[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => _toggleTaskCompletion(task.id),
                    activeColor: Colors.deepPurple,
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: task.isCompleted ? Colors.grey : Colors.black87,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteTask(task.id),
                  ),
                ),
              );
            },
          );
  }

  Widget _buildCounterTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Counter Value',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            '$_counter',
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _decrementCounter,
                heroTag: 'dec',
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.remove, color: Colors.white),
              ),
              const SizedBox(width: 40),
              FloatingActionButton(
                onPressed: _incrementCounter,
                heroTag: 'inc',
                backgroundColor: Colors.green,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'My Tasks' : 'Counter'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.add_task),
              onPressed: _showAddTaskDialog,
              tooltip: 'Add Task',
            ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildTaskTab() : _buildCounterTab(),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _showAddTaskDialog,
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Tasks'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Counter',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
