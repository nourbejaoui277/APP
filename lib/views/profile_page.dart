import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controllers/profile_controller.dart';
import 'order_details_page.dart';
import 'change_password_page.dart';
import 'edit_profile_page.dart';
import 'notifications_page.dart';
import 'privacy_page.dart';
import 'account_management_page.dart';

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
            _buildOrderHistory(context, profileController),
            SizedBox(height: 20),
            _buildSectionTitle('Settings'),
            _buildSettings(context), // Pass context to _buildSettings
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

  Widget _buildOrderHistory(
      BuildContext context, ProfileController profileController) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: profileController.orders.map((order) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Order #${order.id}'),
                subtitle: Text('Placed on ${order.date.toLocal()}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsPage(order: order),
                    ),
                  );
                },
              ),
              Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _buildSettingsTile(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            destination: NotificationsPage(),
          ),
          Divider(height: 1),
          _buildSettingsTile(
            context,
            icon: Icons.privacy_tip,
            title: 'Privacy',
            destination: PrivacyPage(),
          ),
          Divider(height: 1),
          _buildSettingsTile(
            context,
            icon: Icons.account_circle,
            title: 'Account Management',
            destination: AccountManagementPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget destination,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
