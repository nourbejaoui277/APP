import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _wishlistItems.length,
        itemBuilder: (context, index) {
          return _buildWishlistItem(_wishlistItems[index]);
        },
      ),
    );
  }

  // Replace with actual wishlist item data
  List<String> _wishlistItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  Widget _buildWishlistItem(String itemName) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(
              'assets/product_image.jpg'), // Replace with actual image path or network image
        ),
        title: Text(
          itemName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('\$XX.XX'), // Replace with actual price or other details
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            // Implement remove from wishlist functionality
          },
        ),
        onTap: () {
          // Implement navigation to product details or other actions
        },
      ),
    );
  }
}
