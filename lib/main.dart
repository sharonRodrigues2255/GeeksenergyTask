import 'package:flutter/material.dart';
import 'package:flutter_application_4/controller/home_screen_controller.dart';
import 'package:flutter_application_4/model/user_model.dart';
import 'package:flutter_application_4/view/home_screen.dart';
import 'package:flutter_application_4/view/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  final box = Hive.openBox<UserModel>("USER");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenController(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
