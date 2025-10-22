import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_bus2/core/bindings/app_bindings.dart';
import 'package:test_bus2/infra/models/user.dart';
import 'package:test_bus2/presentation/features/user/view/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter()); // typeId: 0
  Hive.registerAdapter(NameAdapter()); // typeId: 1
  Hive.registerAdapter(LocationAdapter()); // typeId: 2
  Hive.registerAdapter(StreetAdapter()); // typeId: 3
  Hive.registerAdapter(CoordinatesAdapter()); // typeId: 4
  Hive.registerAdapter(TimezoneAdapter()); // typeId: 5
  Hive.registerAdapter(LoginAdapter()); // typeId: 6
  Hive.registerAdapter(DobAdapter()); // typeId: 7
  Hive.registerAdapter(RegisteredAdapter()); // typeId: 8
  Hive.registerAdapter(UserIdAdapter()); // typeId: 9
  Hive.registerAdapter(PictureAdapter()); // typeId: 10
  await Hive.openBox<User>('userBox'); // Abre a "caixa"
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Desafio bus 2',
      initialBinding: AppBindings(),
      home: HomeScreen(),
    );
  }
}
