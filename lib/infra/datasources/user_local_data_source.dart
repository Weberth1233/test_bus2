import 'package:hive/hive.dart';
import '../models/user.dart'; // Importe seu modelo User

class UserLocalDataSource {
  final Box<User> _userBox = Hive.box<User>('userBox');

  Future<void> saveUser(User user) async {
    await _userBox.put(user.uuid, user);
  }

  Future<void> deleteUser(String userId) async {
    await _userBox.delete(userId);
  }

  List<User> getAllPersistedUsers() {
    return _userBox.values.toList();
  }
}
