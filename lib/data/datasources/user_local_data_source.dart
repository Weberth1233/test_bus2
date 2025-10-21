import 'package:hive/hive.dart';
import '../models/user.dart'; // Importe seu modelo User

class UserLocalDataSource {
  // 1. Acessamos a "caixa" (Box) do Hive que abrimos no main.dart
  final Box<User> _userBox = Hive.box<User>('userBox');

  /// Salva um usuário no banco de dados local.
  ///
  /// Se um usuário com o mesmo `uuid` (chave) já existir,
  /// ele será substituído (atualizado).
  Future<void> saveUser(User user) async {
    // Usamos o 'uuid' do login como chave única para salvar o usuário.
    // Isso é crucial para que possamos apagar/atualizar ele depois.
    await _userBox.put(user.uuid, user);
  }

  /// Remove um usuário do banco de dados local usando seu ID (uuid).
  Future<void> deleteUser(String userId) async {
    await _userBox.delete(userId);
  }

  /// Retorna uma lista com todos os usuários
  /// que estão salvos no banco de dados.
  List<User> getAllPersistedUsers() {
    // .values retorna todos os itens da "caixa"
    return _userBox.values.toList();
  }
}
