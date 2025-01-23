import 'package:flutter/material.dart';

class SellerProfilePage extends StatelessWidget {
  final String sellerName = 'John Doe';
  final String sellerEmail = 'john@example.com';
  final String storeName = 'John\'s Fashion';
  final String storeDescription =
      'Welcome to John\'s Fashion, where style meets comfort. We offer a wide range of trendy clothing for all ages.';
  final String storeLocation = '123 Fashion St, New York, NY';
  final String storeContact = '+1 (123) 456-7890';

  const SellerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Profile'),
        backgroundColor: const Color(0xFF2F3861),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage('assets/profile_pic.png'), // Add a profile image
            ),
            const SizedBox(height: 20),
            Text(
              sellerName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              sellerEmail,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              title: 'Store Information',
              children: [
                _buildInfoItem(Icons.store, 'Store Name: $storeName'),
                _buildInfoItem(
                    Icons.description, 'Description: $storeDescription'),
                _buildInfoItem(Icons.location_on, 'Location: $storeLocation'),
                _buildInfoItem(Icons.phone, 'Contact: $storeContact'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Connect with Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialMediaIcon(Icons.facebook, Colors.blue),
                const SizedBox(width: 15),
                _buildSocialMediaIcon(Icons.camera_alt, Colors.pink),
                const SizedBox(width: 15),
                _buildSocialMediaIcon(Icons.link, Colors.blueAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required String title, required List<Widget> children}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaIcon(IconData icon, Color color) {
    return InkWell(
      onTap: () {
        // Add navigation or functionality for social media links
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color),
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}
