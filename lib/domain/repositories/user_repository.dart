import 'package:either_dart/either.dart';
import 'package:test_bus2/infra/models/user.dart';

import '../core/failures/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> fetchAndSaveNewUser();
  List<User> getPersistedUsers();
  Future<void> saveUser(User user);
  Future<void> deleteUser(String userId);
}
