import 'package:app1/utilities/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/profile_controller.dart';
import 'views/home_page.dart';
import 'views/login_page.dart';
import 'views/role_selection_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseNourProject db = DatabaseNourProject();
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
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF2F3861), // Updated color globally
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/roleSelection': (context) => RoleSelectionPage(),
          '/clientHome': (context) =>
              HomePage(), // Replace with actual client home page
          '/customerHome': (context) =>
              HomePage(), // Replace with actual customer home page
        },
      ),
    );
  }
}













// import 'package:app1/views/home_page.dart';
// import 'package:app1/views/login_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'controllers/profile_controller.dart';
// import 'package:app1/utilities/database.dart';
// import 'views/role_selection_page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   DatabaseNourProject db = DatabaseNourProject();
//   runApp(MyApp());
// }

// // // Example
// // int userId = await db.registerUser({
// //   'name': 'John Doe',
// //   'email': 'john@example.com',
// //   'phone': '1234567890',
// //   'username': 'john_doe',
// //   'password': 'password123'
// // });
// // print('User registered with id: $userId');

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ProfileController()),
//         //other providers here if needed
//       ],
//       child: MaterialApp(
//         title: 'MyApp',
//         theme: ThemeData(
//           primaryColor: Color(0xFF2F3861),
//           appBarTheme: AppBarTheme(
//             backgroundColor: Color(0xFF2F3861),
//           ),
//         ),
//         home: HomePage(),
//       ),
//     );
//   }
// }
