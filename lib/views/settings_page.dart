import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/settings_controller.dart';
import 'notifications_page.dart';
import 'privacy_page.dart';
import 'account_management_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SettingsController>(
          builder: (context, settingsController, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Notifications'),
                _buildNotificationsSettings(context, settingsController),
                _buildSectionTitle('Privacy'),
                _buildPrivacySettings(context), // Add privacy settings
                _buildSectionTitle('Account Management'),
                _buildAccountManagementSettings(
                    context), // Add account management settings
                // Add other settings sections as needed
              ],
            );
          },
        ),
      ),
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

  Widget _buildNotificationsSettings(
      BuildContext context, SettingsController settingsController) {
    return Column(
      children: [
        ListTile(
          title: Text('Push Notifications'),
          trailing: Switch(
            value: settingsController.pushNotificationsEnabled,
            onChanged: (value) {
              settingsController.setPushNotificationsEnabled(value);
            },
          ),
        ),
        ListTile(
          title: Text('Email Notifications'),
          trailing: Switch(
            value: settingsController.emailNotificationsEnabled,
            onChanged: (value) {
              settingsController.setEmailNotificationsEnabled(value);
            },
          ),
        ),
        ListTile(
          title: Text('View Notifications'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPrivacySettings(BuildContext context) {
    return ListTile(
      title: Text('Privacy Settings'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrivacyPage()),
        );
      },
    );
  }

  Widget _buildAccountManagementSettings(BuildContext context) {
    return ListTile(
      title: Text('Account Management'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountManagementPage()),
        );
      },
    );
  }
}
