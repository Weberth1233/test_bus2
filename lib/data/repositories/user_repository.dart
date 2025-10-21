import 'package:test_bus2/data/models/user.dart';

abstract class UserRepository {
  Future<User> fetchAndSaveNewUser();
  List<User> getPersistedUsers();
  Future<void> saveUser(User user);
  Future<void> deleteUser(String userId);
}
