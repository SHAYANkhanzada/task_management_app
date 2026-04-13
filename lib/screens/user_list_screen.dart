import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';
import 'user_profile_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<UserModel>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _apiService.fetchUsers();
  }

  void _refreshUsers() {
    setState(() {
      _usersFuture = _apiService.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Users'),
        actions: [
          IconButton(
            onPressed: _refreshUsers,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshUsers,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePicture!),
                  ),
                  title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(user.email),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfileScreen(user: user),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
