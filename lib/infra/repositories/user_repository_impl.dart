import 'package:test_bus2/infra/datasources/user_local_data_source.dart';
import 'package:test_bus2/infra/datasources/user_remote_data_source.dart';
import 'package:test_bus2/infra/models/user.dart';
import 'package:test_bus2/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<void> deleteUser(String userId) async {
    await localDataSource.deleteUser(userId);
  }

  @override
  Future<User> fetchAndSaveNewUser() async {
    try {
      //Buscar na API
      final user = await remoteDataSource.getNewUser();
      //Salvar localmente
      await localDataSource.saveUser(user);
      return user;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  List<User> getPersistedUsers() {
    return localDataSource.getAllPersistedUsers();
  }

  @override
  Future<void> saveUser(User user) async {
    await localDataSource.saveUser(user);
  }
}
