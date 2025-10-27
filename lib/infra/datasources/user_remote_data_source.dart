import 'dart:convert';

import 'package:test_bus2/infra/core/errors/exceptions.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserRemoteDataSource {
  final String _baseUrl = 'https://randomuser.me/api/';

  Future<User> getNewUser() async {
    final response = await http.get(Uri.parse(_baseUrl));
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userJson = data['results'][0];
        final user = User.fromJson(userJson);
        return user;
      } else if (response.statusCode == 404) {
        throw NotFoundException('Recurso não encontrado ${response.body}');
      } else if (response.statusCode == 500) {
        throw ServerException('Erro no servidor: ${response.body}');
      } else {
        throw UnknownException(
          'Ocorreu alguma falha na API ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
