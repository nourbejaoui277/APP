import 'package:app1/utilities/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app1/controllers/profile_controller.dart';
import 'package:app1/views/login_page.dart';
import 'views/home_page.dart';
import 'package:app1/component/custom_footer.dart';

void main() {
  DatabaseNourProject().initializeDb();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProfileController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
