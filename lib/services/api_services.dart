import 'dart:developer';

import 'package:calibort_assignment/models/user_model.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio();

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://reqres.in/api/login',
        data: {'email': email, 'password': password},
      );
      return response.data['token'];
    } catch (e) {
      throw Exception('Login Issue Occoured');
    }
  }

  Future<List<User>> fetchUsers(int page) async {
    try {
      final response = await _dio
          .get('https://reqres.in/api/users', queryParameters: {'page': page});
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}
