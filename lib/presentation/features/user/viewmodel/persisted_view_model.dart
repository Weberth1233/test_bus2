import 'package:get/get.dart';
import 'package:test_bus2/domain/repositories/user_repository.dart';

import '../../../../infra/models/user.dart';

class PersistedViewModel extends GetxController {
  final UserRepository _userRepository = Get.find();
  final RxList<User> persistedList = <User>[].obs;

  void loadUsers() {
    persistedList.value = _userRepository.getPersistedUsers();
  }

  Future<void> saveUser(User user) async {
    await _userRepository.saveUser(user);
    loadUsers();
    Get.snackbar('Salvo com sucesso!', "Usuário salvo nos persistidos!");
  }

  Future<void> deleteUser(String userId) async {
    //Apagar o usuário e chama a lista de novo
    await _userRepository.deleteUser(userId);
    loadUsers();
    Get.snackbar('Deletado com sucesso!', "Usuário deletado dos persistidos!");
  }

  bool isUserPersisted(String userId) {
    //Caso ele retorna true é pra deixar o remover habilitado, pois ele encontrou na lista, caso contrario ele retorna false, pois não encontrou na lista
    return persistedList.any((user) => user.uuid == userId);
  }
}
