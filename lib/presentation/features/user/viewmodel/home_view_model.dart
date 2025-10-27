import 'package:get/get.dart';
import 'package:test_bus2/domain/repositories/user_repository.dart';

import '../../../../domain/core/failures/failures.dart';
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
      final result = await _userRepository.fetchAndSaveNewUser();
      result.fold(
        (failure) {
          _handleFailure(failure);
        },
        (user) {
          userList.add(user);
        },
      );
    } catch (e) {
      Get.snackbar('Erro de rede', "Falha ao buscar novo usuário");
    } finally {
      if (isLoading.value) {
        isLoading.value = false;
      }
    }
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerFailure) {
      Get.defaultDialog(
        title: 'Erro no servidor!',
        middleText: failure.message,
      );
    } else if (failure is NotFoundFailure) {
      Get.defaultDialog(
        title: 'Erro na requisição!',
        middleText: failure.message,
      );
    } else if (failure is UnknownFailure) {
      Get.defaultDialog(
        title: 'Erro desconhecido!',
        middleText: failure.message,
      );
    }
  }
}
