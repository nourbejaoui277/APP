import 'package:flutter/material.dart';
import 'package:app1/services/auth_service.dart';

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({super.key});

  @override
  _SellerHomePageState createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  final AuthService _authService = AuthService();
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _checkRole();
  }

  // Check the role of the user (admin/seller) when the page is loaded
  Future<void> _checkRole() async {
    String? role = await _authService.getUserRole();
    setState(() {
      userRole = role ?? ''; // Update the state based on role
    });
    print("User role is: $userRole"); // Debugging line to check the role
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const WelcomeMessage(),
            const SizedBox(height: 20),
            // Check user role and show relevant options
            if (userRole == 'admin') ...[
              DashboardButton(
                icon: Icons.add_box,
                label: 'Add Product',
                onTap: () => _navigateTo(context, '/addProduct'),
              ),
              DashboardButton(
                icon: Icons.list_alt,
                label: 'Manage Orders',
                onTap: () => _navigateTo(context, '/manageOrders'),
              ),
            ],
            if (userRole == 'seller') ...[
              DashboardButton(
                icon: Icons.add_box,
                label: 'Add Product',
                onTap: () => _navigateTo(context, '/addProduct'),
              ),
              DashboardButton(
                icon: Icons.list_alt,
                label: 'Manage Orders',
                onTap: () => _navigateTo(context, '/manageOrders'),
              ),
            ],
            DashboardButton(
              icon: Icons.person,
              label: 'Seller Profile',
              onTap: () => _navigateTo(context, '/sellerProfile'),
            ),
            DashboardButton(
              icon: Icons.bar_chart,
              label: 'Sales Dashboard',
              onTap: () => _navigateTo(context, '/salesDashboard'),
            ),
            // Show error message if the role is empty
            if (userRole.isEmpty) ...[
              const Text("Error: User role not found or invalid."),
            ]
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String routeName) {
    try {
      Navigator.pushNamed(context, routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error navigating to $routeName: $e')),
      );
    }
  }
}

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      elevation: 2,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, Seller!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Here is your dashboard. Manage your store efficiently!'),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const DashboardButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(label, style: const TextStyle(fontSize: 16)),
        onTap: onTap,
      ),
    );
  }
}
