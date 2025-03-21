import 'package:app1/utilities/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/profile_controller.dart';
import 'views/home_page.dart';
import 'views/login_page.dart';
import 'views/role_selection_page.dart';
import 'views/seller_home_page.dart';
import 'package:app1/views/add_product_page.dart';
import 'package:app1/views/manage_orders_page.dart';
import 'package:app1/views/seller_profile_page.dart';
import 'package:app1/views/sales_dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseNourProject db = DatabaseNourProject();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: MaterialApp(
        title: 'MyApp',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2F3861), // Updated color globally
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/roleSelection': (context) => RoleSelectionPage(),
          '/clientHome': (context) => const HomePage(),
          '/sellerHome': (context) => const SellerHomePage(),
          '/addProduct': (context) => const AddProductPage(),
          '/manageOrders': (context) => ManageOrdersPage(),
          '/sellerProfile': (context) => SellerProfilePage(),
          '/salesDashboard': (context) => SalesDashboardPage(),
        },
      ),
    );
  }
}
