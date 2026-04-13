import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const TaskManagementApp(),
    ),
  );
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
