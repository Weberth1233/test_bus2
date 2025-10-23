import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_bus2/presentation/features/user/viewmodel/persisted_view_model.dart';

// Importe seu controller e suas telas
import 'details_screen.dart';

class PersistedScreen extends StatelessWidget {
  // Pega a instância do controller que o GetX já criou
  final PersistedViewModel controller = Get.find();

  PersistedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários Persistidos')),
      // Envolve a lista com Obx para que ela reaja
      // às mudanças na `persistedList.obs`
      body: Obx(() {
        // Se a lista reativa estiver vazia
        if (controller.persistedList.isEmpty) {
          return const Center(
            child: Text('Nenhum usuário salvo no banco de dados.'),
          );
        }

        // Se tiver dados, mostre a lista
        return ListView.builder(
          itemCount: controller.persistedList.length,
          itemBuilder: (context, index) {
            final user = controller.persistedList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.picture.thumbnail),
              ),
              title: Text(user.name.fullName),
              subtitle: Text(user.email),

              // Ação de clique para ver detalhes
              onTap: () {
                Get.to(() => DetailsScreen(user: user));
              },

              // Ação para REMOVER (requisito do desafio)
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  // Chama o método do controller para apagar o usuário
                  controller.deleteUser(user.uuid);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
