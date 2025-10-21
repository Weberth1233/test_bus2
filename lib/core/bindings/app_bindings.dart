import 'package:get/get.dart';
import 'package:test_bus2/data/datasources/user_local_data_source.dart';
import 'package:test_bus2/data/datasources/user_remote_data_source.dart';
import 'package:test_bus2/data/repositories/user_repository.dart';
import 'package:test_bus2/data/repositories/user_repository_impl.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => UserRemoteDataSource());
    Get.lazyPut(() => UserLocalDataSource());

    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        remoteDataSource: Get.find<UserRemoteDataSource>(),
        localDataSource: Get.find<UserLocalDataSource>(),
      ),
    );
  }
}
