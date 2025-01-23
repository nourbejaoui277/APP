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
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2F3861),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context, profileController),
            const SizedBox(height: 20),
            _buildSectionTitle('Personal Information'),
            _buildPersonalInfo(context, profileController),
            const SizedBox(height: 20),
            _buildSectionTitle('Order History'),
            _buildOrderHistory(context, profileController),
            const SizedBox(height: 20),
            _buildSectionTitle('Settings'),
            _buildSettings(context),
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
            const CircleAvatar(
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
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.edit, size: 15, color: Colors.purple),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profileController.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              profileController.email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              'Phone: ${profileController.phone}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPersonalInfo(
      BuildContext context, ProfileController profileController) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF2F3861)),
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.lock, color: Color(0xFF2F3861)),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: profileController.orders.map((order) {
          return Column(
            children: [
              ListTile(
                leading:
                    const Icon(Icons.shopping_cart, color: Color(0xFF2F3861)),
                title: Text('Order #${order.id}'),
                subtitle: Text('Placed on ${order.date.toLocal()}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsPage(order: order),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _buildSettingsTile(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            destination: NotificationsPage(),
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            context,
            icon: Icons.privacy_tip,
            title: 'Privacy',
            destination: PrivacyPage(),
          ),
          const Divider(height: 1),
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
      leading: Icon(icon, color: const Color(0xFF2F3861)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
