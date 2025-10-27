import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_bus2/presentation/core/bindings/app_bindings.dart';
import 'package:test_bus2/infra/models/user.dart';
import 'package:test_bus2/presentation/features/user/view/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(NameAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(StreetAdapter());
  Hive.registerAdapter(CoordinatesAdapter());
  Hive.registerAdapter(TimezoneAdapter());
  Hive.registerAdapter(LoginAdapter());
  Hive.registerAdapter(DobAdapter());
  Hive.registerAdapter(RegisteredAdapter());
  Hive.registerAdapter(UserIdAdapter());
  Hive.registerAdapter(PictureAdapter());
  await Hive.openBox<User>('userBox');
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
