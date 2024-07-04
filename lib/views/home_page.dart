import 'package:flutter/material.dart';
import 'categories_page.dart';
import 'discover_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sparkling'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Categories'),
            _buildCategories(),
            _buildSectionTitle('Promotions'),
            _buildPromotions(),
            _buildSectionTitle('Best Sellers'),
            _buildBestSellers(),
            _buildSectionTitle('Pick a Style or Mood'),
            _buildStyleMoodPicker(),
            _buildSectionTitle('Selections for You'),
            _buildSelectionsForYou(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
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

  Widget _buildCategories() {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryCard('Men'),
          _buildCategoryCard('Women'),
          _buildCategoryCard('Kids'),
          _buildCategoryCard('Accessories'),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String category) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: Colors.purple.withOpacity(0.1),
      child: Container(
        width: 100,
        child: Center(child: Text(category)),
      ),
    );
  }

  Widget _buildPromotions() {
    // Replace with your actual promotion data
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: Text('Promotion 1')),
    );
  }

  Widget _buildBestSellers() {
    // Replace with your actual best sellers data
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: Text('Best Seller 1')),
    );
  }

  Widget _buildStyleMoodPicker() {
    // Replace with your actual style/mood picker data
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: Text('Style/Mood Picker')),
    );
  }

  Widget _buildSelectionsForYou() {
    // Replace with your actual selections data
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.purpleAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: Text('Selections for You')),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Me',
        ),
      ],
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            // Navigate to Home (if necessary)
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoriesPage()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiscoverPage()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WishlistPage()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
            break;
          default:
          // Navigate to Home or handle other cases
        }
      },
    );
  }
}
