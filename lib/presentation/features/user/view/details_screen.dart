import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infra/models/user.dart';
import '../viewmodel/persisted_view_model.dart';

class DetailsScreen extends StatelessWidget {
  final User user;
  final PersistedViewModel controller = Get.find();

  DetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            Text('Name:', style: TextStyle(fontSize: 15)),
            Text(user.name.title),
            Text(user.name.first),
            Text(user.name.last),
            SizedBox(height: 10),
            Divider(),
            Text('Location'),
            Text(user.location.street.number.toString()),
            Text(user.location.street.name),
            Text(user.location.city),
            SizedBox(height: 10),
            Divider(),
            Text(user.email),
            SizedBox(height: 10),
            Divider(),
            Text(user.login.username),
            Text(user.login.password),
            controller.isUserPersisted(user.uuid)
                ? ElevatedButton(
                    onPressed: () {
                      controller.deleteUser(user.uuid);
                    },
                    child: Text('Remover'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      controller.saveUser(user);
                    },
                    child: Text('Salvar'),
                  ),
            // ElevatedButton(onPressed: () {}, child: Text('Remover')),
          ],
        ),
      ),
    );
  }
}
