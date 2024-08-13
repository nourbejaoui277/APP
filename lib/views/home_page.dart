import 'package:flutter/material.dart';
import 'categories_page.dart';
import 'discover_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AURA'),
        backgroundColor: Color.fromRGBO(47, 56, 97, 0),
      ),
      body: _buildPageContent(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildPageContent() {
    switch (pageIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return CategoriesPage(category: "category");
      case 2:
        return DiscoverPage();
      case 3:
        return WishlistPage();
      case 4:
        return ProfilePage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPageTitle('AURA'),
          SizedBox(height: 16),
          _buildCategories(context),
          SizedBox(height: 16),
          _buildSectionTitle('Promotions'),
          _buildPromotions(),
          SizedBox(height: 16),
          _buildSectionTitle('Best Sellers'),
          _buildBestSellers(),
          SizedBox(height: 16),
          _buildSectionTitle('Style/Mood Picker'),
          _buildStyleMoodPicker(),
          SizedBox(height: 16),
          _buildSectionTitle('Selections for You'),
          _buildSelectionsForYou(),
          SizedBox(height: 16),
          //ElevatedButton(
          //onPressed: () {
          //Navigator.pushNamed(
          //  context, '/settings'); // Navigate to SettingsPage
          //},
          //child: Text('Go to Settings'),
          // ),
        ],
      ),
    );
  }

  Widget _buildPageTitle(String title) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.purple,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
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

  Widget _buildCategories(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryCard('Men', 'assets/images/men.jpg', context),
          _buildCategoryCard('Women', 'assets/images/women.jpg', context),
          _buildCategoryCard('Kids', 'assets/images/kids.jpg', context),
          _buildCategoryCard(
              'Accessories', 'assets/images/accessories.jpg', context),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      String category, String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoriesPage(category: category)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromotions() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
          child: Text('Promotion 1',
              semanticsLabel: 'assets/images/promotion.jpg')),
    );
  }

  Widget _buildBestSellers() {
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromRGBO(47, 56, 97, 0).withOpacity(0.1),
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
      currentIndex: pageIndex,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        setState(() {
          pageIndex = index;
        });
      },
    );
  }
}
