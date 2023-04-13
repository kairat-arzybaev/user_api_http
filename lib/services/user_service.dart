import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserService {
  Future<List<User>> getUser() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=50'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<User> list = [];
      for (var item in data['results']) {
        list.add(User.fromJson(item));
      }
      return list;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
