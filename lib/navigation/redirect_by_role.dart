import 'package:flutter/material.dart';
import 'package:app1/views/home_page.dart';
import 'package:app1/views/seller/seller_home_page.dart';
import 'package:app1/views/seller/boutique_setup_page.dart';
import 'package:app1/services/auth_service.dart';
import 'package:app1/views/signuplogin/login_page.dart';

import '../utilities/shared_preferences.dart';

class RoleRedirect extends StatelessWidget {
  //final AuthService _authService = AuthService();
  final String role = SharedPreference.getUserRole()!;

  RoleRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    // return //Scaffold(
    // future: SharedPreference.getUserRole()!, // _authService.getUserRole(),
    // builder: (context, snapshot) {
    //   if (snapshot.connectionState == ConnectionState.waiting) {
    //     return const Center(child: CircularProgressIndicator());
    //   }

    //   if (snapshot.hasError || snapshot.data == null) {
    //     debugPrint("RoleRedirect error or no role: ${snapshot.error}");
    //     return const LoginPage();
    //   }

    //   final role = snapshot.data!;
    //   debugPrint("RoleRedirect navigating with role: $role");

    switch (role) {
      case 'Seller':
        return const SellerHomePage();
      case 'seller_needs_setup':
        return const BoutiqueSetupPage();
      case 'Customer':
        return const HomePage();
      default:
        debugPrint("Unknown role: $role, redirecting to LoginPage");
        return const LoginPage();
    }
    // },
    // );
  }
}
