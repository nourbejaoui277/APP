import 'package:flutter/material.dart';

class WomenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Women'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPageTitle('Women'),
            SizedBox(height: 16),
            _buildCategories(context),
            SizedBox(height: 16),
            _buildSectionTitle('New Arrivals'),
            _buildNewArrivals(),
            SizedBox(height: 16),
            _buildSectionTitle('Popular Picks'),
            _buildPopularPicks(),
            SizedBox(height: 16),
            _buildSectionTitle('Trending Now'),
            _buildTrendingNow(),
            SizedBox(height: 16),
            _buildSectionTitle('Recommended for You'),
            _buildRecommendedForYou(),
            SizedBox(height: 16),
          ],
        ),
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
          _buildCategoryCard(
              'Dresses', 'assets/images/women_dress.jpg', context),
          _buildCategoryCard('Tops', 'assets/images/women_tops.jpg', context),
          _buildCategoryCard('Jeans', 'assets/images/women_jeans.jpg', context),
          _buildCategoryCard('Shoes', 'assets/images/women_shoes.jpg', context),
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
              builder: (context) =>
                  WomenPage()), // Or navigate to a specific category page
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

  Widget _buildNewArrivals() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.pinkAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: Text('New Arrivals')),
    );
  }

  Widget _buildPopularPicks() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: Text('Popular Picks')),
    );
  }

  Widget _buildTrendingNow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: Text('Trending Now')),
    );
  }

  Widget _buildRecommendedForYou() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.purpleAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: Text('Recommended for You')),
    );
  }
}









// import 'package:flutter/material.dart';

// class WomenPage extends StatelessWidget {
//   final List<Map<String, String>> womenProducts = [
//     {
//       'name': 'Women\'s Dress',
//       'description': 'Elegant evening dress',
//       'price': '\$50',
//     },
//     {
//       'name': 'Women\'s Handbag',
//       'description': 'Stylish leather handbag',
//       'price': '\$80',
//     },
//     {
//       'name': 'Women\'s Shoes',
//       'description': 'Comfortable running shoes',
//       'price': '\$70',
//     },
//     // Add more products as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Women\'s Category'),
//         backgroundColor: Colors.purple,
//       ),
//       body: ListView.builder(
//         itemCount: womenProducts.length,
//         itemBuilder: (context, index) {
//           return Card(
//             elevation: 3,
//             margin: EdgeInsets.all(10),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: ListTile(
//               title: Text(
//                 womenProducts[index]['name']!,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(womenProducts[index]['description']!),
//               trailing: Text(
//                 womenProducts[index]['price']!,
//                 style: TextStyle(fontSize: 16, color: Colors.green),
//               ),
//               onTap: () {
//                 // Handle item tap if needed
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
