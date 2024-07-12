import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Featured Products'),
            SizedBox(height: 10),
            _buildFeaturedProducts(),
            SizedBox(height: 20),
            _buildSectionTitle('Personalized Recommendations'),
            SizedBox(height: 10),
            _buildRecommendations(),
            SizedBox(height: 20),
            _buildFilters(),
          ],
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

  Widget _buildFeaturedProducts() {
    return Container(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildProductCard('Product 1', 'assets/product1.jpg', '\$99.99'),
          _buildProductCard('Product 2', 'assets/product2.jpg', '\$79.99'),
          _buildProductCard('Product 3', 'assets/product3.jpg', '\$129.99'),
          _buildProductCard('Product 4', 'assets/product4.jpg', '\$49.99'),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String imagePath, String price) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      price,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendations() {
    return Column(
      children: [
        _buildRecommendationCard(
            'Recommended Product 1', 'assets/recommendation1.jpg', '\$119.99'),
        SizedBox(height: 10),
        _buildRecommendationCard(
            'Recommended Product 2', 'assets/recommendation2.jpg', '\$89.99'),
      ],
    );
  }

  Widget _buildRecommendationCard(String name, String imagePath, String price) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(name),
        subtitle: Text(price),
        onTap: () {},
      ),
    );
  }

  Widget _buildFilters() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(Icons.filter_list),
        title: Text('Apply Filters'),
        onTap: () {},
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: DiscoverPage(),
    );
  }
}
