import 'package:flutter/material.dart';
import 'package:app1/views/men_page.dart';
import 'package:app1/views/women_page.dart';
import 'kids_page.dart';
import 'accessories_page.dart';
import 'shoes_page.dart';
import 'electronics_page.dart';

class CategoriesPage extends StatelessWidget {
  final String category;

  CategoriesPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Colors.purple,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryCard(context, _categories[index]);
        },
      ),
    );
  }

  List<String> _categories = [
    'Men',
    'Women',
    'Kids',
    'Accessories',
    'Shoes',
    'Electronics',
  ];

  Widget _buildCategoryCard(BuildContext context, String category) {
    return GestureDetector(
      onTap: () {
        _navigateToCategory(context, category);
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category,
              size: 50,
              color: Colors.purple,
            ),
            SizedBox(height: 10),
            Text(
              category,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    switch (category) {
      case 'Men':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenPage()),
        );
        break;
      case 'Women':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WomenPage()),
        );
        break;
      case 'Kids':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KidsPage()),
        );
        break;
      case 'Accessories':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccessoriesPage()),
        );
        break;
      case 'Shoes':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShoesPage()),
        );
        break;
      case 'Electronics':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ElectronicsPage()),
        );
        break;
      default:
        // Handle other categories or default case
        break;
    }
  }
}
