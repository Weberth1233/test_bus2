import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_bus2/presentation/features/user/viewmodel/home_view_model.dart';

import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// 1. Precisamos do 'SingleTickerProviderStateMixin'
// para fornecer o 'vsync' ao AnimationController.
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // 2. Pegue a instância do seu ViewModel (Controller) do GetX
  final HomeViewModel controller = Get.find();

  // 3. Declare o AnimationController
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // 4. Inicialize o AnimationController com 5 segundos
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // 5. Adicione um "ouvinte" ao status da animação
    _animationController.addStatusListener((status) {
      // Quando a animação de 5s for concluída...
      if (status == AnimationStatus.completed) {
        // ...execute a ação de buscar um novo usuário
        controller.fetchNewUser();

        // ...e reinicie a contagem de 5 segundos
        _animationController.forward(from: 0.0);
      }
    });

    // 6. Inicie a primeira contagem de 5 segundos
    // (O primeiro usuário já foi buscado no 'onInit' do controller,
    // então isso vai buscar o *segundo* usuário após 5s)
    _animationController.forward();
  }

  @override
  void dispose() {
    // 7. É OBRIGATÓRIO descartar o controller
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novos Usuários'),
        actions: [
          IconButton(
            icon: const Icon(Icons.data_usage_rounded),
            onPressed: () {},
          ),
        ],
      ),
      // 8. Use o 'Obx' para ouvir as variáveis '.obs' do seu controller
      body: Obx(() {
        // Se estiver carregando (primeira vez) E a lista estiver vazia
        if (controller.isLoading.value && controller.userList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Se a lista estiver vazia após o carregamento
        if (controller.userList.isEmpty) {
          return const Center(child: Text('Nenhum usuário encontrado.'));
        }

        // 9. Se tiver dados, construa a lista
        return ListView.builder(
          itemCount: controller.userList.length,
          itemBuilder: (context, index) {
            final user = controller.userList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.picture.thumbnail),
              ),
              title: Text(user.name.fullName),
              subtitle: Text(user.email),
              onTap: () {
                Get.to(() => DetailsScreen(user: user));
                // Navega para a tela de detalhes passando o objeto 'user'
              },
            );
          },
        );
      }),
    );
  }
}
