import 'package:app1/navigation/redirect_by_role.dart';
import 'package:app1/utilities/database.dart';
import 'package:app1/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/profile_controller.dart';
import 'views/signuplogin/login_page.dart';
import 'views/home_page.dart';
import 'views/settings_page.dart';
import 'views/seller/boutique_setup_page.dart';
import 'views/seller/seller_home_page.dart';
import 'views/seller/add_product_page.dart';
import 'views/seller/orders_page.dart';
import 'views/seller/products_page.dart';
import 'views/seller/promotions_page.dart';
import 'package:app1/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference.init();
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
        title: 'Aura',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2F3861),
          ),
        ),
        home: LoginPage(),
        routes: {
          // '/Homepage': (context) => const HomePage(),
          '/sellerHome': (context) => const SellerHomePage(),
          '/boutiqueSetup': (context) => const BoutiqueSetupPage(),
          // '/settings': (context) => const SettingsPage(),
          // '/addProduct': (context) => const AddProductPage(),
          '/orders': (context) => const OrdersPage(
                boutiqueId: '',
              ),
          '/products': (context) => const ProductsPage(),
          '/promotions': (context) => const PromotionsPage(),
          '/roleRedirect': (context) => RoleRedirect(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
