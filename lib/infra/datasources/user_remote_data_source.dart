import 'dart:convert';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserRemoteDataSource {
  final String _baseUrl = 'https://randomuser.me/api/';

  Future<User> getNewUser() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final userJson = data['results'][0];
      final user = User.fromJson(userJson);
      return user;
    } else {
      throw Exception('Ocorreu alguma falha na API');
    }
  }
}
