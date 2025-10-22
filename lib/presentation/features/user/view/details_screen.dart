import 'package:flutter/material.dart';

import '../../../../infra/models/user.dart';

class DetailsScreen extends StatelessWidget {
  final User user;
  const DetailsScreen({super.key, required this.user});

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
          ],
        ),
      ),
    );
  }
}
