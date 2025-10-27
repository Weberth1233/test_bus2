import 'package:get/get.dart';
import 'package:test_bus2/infra/datasources/user_local_data_source.dart';
import 'package:test_bus2/infra/datasources/user_remote_data_source.dart';
import 'package:test_bus2/domain/repositories/user_repository.dart';
import 'package:test_bus2/infra/repositories/user_repository_impl.dart';
import 'package:test_bus2/presentation/features/user/viewmodel/home_view_model.dart';
import 'package:test_bus2/presentation/features/user/viewmodel/persisted_view_model.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => PersistedViewModel());
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
