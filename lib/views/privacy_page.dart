import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool showProfilePicture = true;
  bool shareDataWithThirdParties = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2F3861),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPrivacySettingCard(
              title: 'Show Profile Picture',
              subtitle: 'Allow others to see your profile picture',
              value: showProfilePicture,
              onChanged: (value) {
                setState(() {
                  showProfilePicture = value;
                });
              },
              icon: Icons.account_circle,
            ),
            const SizedBox(height: 16),
            _buildPrivacySettingCard(
              title: 'Share Data with Third Parties',
              subtitle: 'Allow your data to be shared with third parties',
              value: shareDataWithThirdParties,
              onChanged: (value) {
                setState(() {
                  shareDataWithThirdParties = value;
                });
              },
              icon: Icons.share,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySettingCard({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required IconData icon,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 30, color: const Color(0xFF2F3861)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF2F3861),
            ),
          ],
        ),
      ),
    );
  }
}
