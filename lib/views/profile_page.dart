import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_profile_page.dart';
import 'change_password_page.dart';
import 'package:app1/controllers/profile_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProfileController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context, profileController),
            SizedBox(height: 20),
            _buildSectionTitle('Personal Information'),
            _buildPersonalInfo(context, profileController),
            SizedBox(height: 20),
            _buildSectionTitle('Order History'),
            _buildOrderHistory(),
            SizedBox(height: 20),
            _buildSectionTitle('Settings'),
            _buildSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context, ProfileController profileController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile_pic.jpg'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Implement edit profile picture functionality
                },
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.edit, size: 15, color: Colors.purple),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profileController.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              profileController.email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              'Phone: ${profileController.phone}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPersonalInfo(
      BuildContext context, ProfileController profileController) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    profileController: profileController,
                    name: '',
                    email: '',
                    phone: '',
                  ),
                ),
              );
            },
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHistory() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Order #12345'),
            subtitle: Text('Placed on 12th June 2024'),
            onTap: () {
              // Implement view order details functionality
            },
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Order #12346'),
            subtitle: Text('Placed on 15th June 2024'),
            onTap: () {},
          ),
          Divider(height: 1),
          ListTile(
            title: Center(child: Text('View All Orders')),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {},
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy'),
            onTap: () {},
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account Management'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
