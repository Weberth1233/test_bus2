import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_bus2/presentation/features/user/viewmodel/persisted_view_model.dart';

import '../../../../infra/models/user.dart';

// Importe seu modelo e o controller de persistência

class DetailsScreen extends StatelessWidget {
  // 1. Recebe o objeto 'User' da tela anterior
  final User user;

  // 2. Pega a instância do PersistedController
  final PersistedViewModel controller = Get.find();

  DetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Mostra o nome completo do usuário no título
        title: Text(user.name.fullName),
      ),
      body: ListView(
        // Adiciona um padding em volta de toda a lista
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.picture.large),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            final bool isSaved = controller.isUserPersisted(user.uuid);
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSaved ? Colors.red : Colors.green,
              ),
              onPressed: () {
                if (isSaved) {
                  controller.deleteUser(user.uuid);
                } else {
                  controller.saveUser(user);
                }
              },
              child: Text(
                isSaved ? 'Remover dos Persistidos' : 'Salvar nos Persistidos',
              ),
            );
          }),
          const SizedBox(height: 16),
          ExpansionTile(
            title: const Text('Informações Pessoais'),
            initiallyExpanded: true, // Deixa aberto por padrão
            children: [
              _buildDetailRow('Nome', user.name.fullName),
              _buildDetailRow('Email', user.email),
              _buildDetailRow('Gênero', user.gender),
              _buildDetailRow('Data de Nasc.', user.dob.date),
              _buildDetailRow('Idade', user.dob.age.toString()),
            ],
          ),

          // --- Grupo 2: Localização ---
          ExpansionTile(
            title: const Text('Localização'),
            children: [
              _buildDetailRow(
                'Endereço',
                '${user.location.street.name}, ${user.location.street.number}',
              ),
              _buildDetailRow('Cidade', user.location.city),
              _buildDetailRow('Estado', user.location.state),
              _buildDetailRow('País', user.location.country),
              _buildDetailRow('CEP', user.location.postcode),
              _buildDetailRow(
                'Coordenadas',
                '${user.location.coordinates.latitude}, ${user.location.coordinates.longitude}',
              ),
            ],
          ),

          // --- Grupo 3: Login e Contato ---
          ExpansionTile(
            title: const Text('Login e Contato'),
            children: [
              _buildDetailRow('Username', user.login.username),
              _buildDetailRow('Telefone', user.phone),
              _buildDetailRow('Celular', '(${user.cell})'),
              // É útil poder copiar o UUID
              _buildDetailRow('UUID', user.uuid, isSelectable: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String title,
    String value, {
    bool isSelectable = false,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: isSelectable
          ? SelectableText(value, style: const TextStyle(fontSize: 16))
          : Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}
