import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/storage_service.dart';
import '../providers/task_provider.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'user_list_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  
  int _selectedIndex = 0;
  final TextEditingController _taskController = TextEditingController();

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final counter = await _storageService.getCounter();
    setState(() {
      _counter = counter;
    });
  }

  void _addTask() {
    if (_taskController.text.trim().isEmpty) return;
    context.read<TaskProvider>().addTask(_taskController.text.trim());
    _taskController.clear();
    Navigator.pop(context);
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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

  void _incrementCounter() {
    setState(() { _counter++; });
    _storageService.saveCounter(_counter);
  }

  void _decrementCounter() {
    setState(() { _counter--; });
    _storageService.saveCounter(_counter);
  }

  Widget _buildTaskTab() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        if (taskProvider.isLoading) return const Center(child: CircularProgressIndicator());
        if (taskProvider.tasks.isEmpty) {
          return const Center(
            child: Text('No tasks yet. Add one!', style: TextStyle(fontSize: 18, color: Colors.grey)),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            final task = taskProvider.tasks[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) => taskProvider.toggleTaskCompletion(task.id),
                  activeColor: Colors.deepPurple,
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    color: task.isCompleted ? Colors.grey : Colors.black87,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => taskProvider.deleteTask(task.id),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCounterTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Counter Value', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text('$_counter', style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(onPressed: _decrementCounter, heroTag: 'dec', backgroundColor: Colors.redAccent, child: const Icon(Icons.remove, color: Colors.white)),
              const SizedBox(width: 40),
              FloatingActionButton(onPressed: _incrementCounter, heroTag: 'inc', backgroundColor: Colors.green, child: const Icon(Icons.add, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    final User? user = _authService.currentUser;
    if (user == null) return const Center(child: Text('Not logged in'));

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestoreService.userDataStream(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        if (!snapshot.hasData || !snapshot.data!.exists) {
          // If Firestore Doc doesn't exist yet, show Auth user info
          return _buildProfileContent(user.email ?? 'No email', 'Firebase User', user.uid);
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        return _buildProfileContent(data['email'], data['name'], user.uid);
      },
    );
  }

  Widget _buildProfileContent(String email, String name, String uid) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.person, size: 80, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(Icons.fingerprint),
            title: const Text('User ID'),
            subtitle: Text(uid),
          ),
          const Divider(),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () async {
              await _authService.signOut();
              if (mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() { _selectedIndex = index; });
  }

  @override
  Widget build(BuildContext context) {
    String title = 'My Tasks';
    if (_selectedIndex == 1) title = 'Counter';
    if (_selectedIndex == 2) title = 'API Users';
    if (_selectedIndex == 3) title = 'My Profile';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          if (_selectedIndex == 0)
            IconButton(icon: const Icon(Icons.add_task), onPressed: _showAddTaskDialog, tooltip: 'Add Task'),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildTaskTab(),
          _buildCounterTab(),
          const UserListScreen(),
          _buildProfileTab(),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(onPressed: _showAddTaskDialog, backgroundColor: Colors.deepPurple, child: const Icon(Icons.add, color: Colors.white))
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Counter'),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}



