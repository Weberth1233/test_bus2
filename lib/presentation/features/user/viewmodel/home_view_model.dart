import 'package:get/get.dart';
import 'package:test_bus2/domain/repositories/user_repository.dart';

import '../../../../infra/models/user.dart';

class HomeViewModel extends GetxController {
  final UserRepository _userRepository = Get.find();

  RxList<User> userList = <User>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNewUser();
  }

  Future<void> fetchNewUser() async {
    if (userList.isEmpty) {
      isLoading.value = true;
    }
    try {
      final newUser = await _userRepository.fetchAndSaveNewUser();
      userList.add(newUser);
    } catch (e) {
      Get.snackbar('Erro de rede', "Falha ao buscar novo usuário");
    } finally {
      if (isLoading.value) {
        isLoading.value = false;
      }
    }
  }
}
