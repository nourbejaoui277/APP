import 'package:app1/views/home_page.dart';
import 'package:app1/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/profile_controller.dart';
import 'package:app1/utilities/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseNourProject db = DatabaseNourProject();

  // // Example
  // int userId = await db.registerUser({
  //   'name': 'John Doe',
  //   'email': 'john@example.com',
  //   'phone': '1234567890',
  //   'username': 'john_doe',
  //   'password': 'password123'
  // });
  // print('User registered with id: $userId');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileController()),
        //other providers here if needed
      ],
      child: MaterialApp(
        title: 'MyApp',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: LoginPage(),
      ),
    );
  }
}
