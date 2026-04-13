import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'FlutterTaskApp/1.0',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => UserModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<UserModel> fetchUserById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'FlutterTaskApp/1.0',
        },
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load user detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
