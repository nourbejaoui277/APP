import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<String> _wishlistItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

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
            _removeFromWishlist(itemName);
          },
        ),
        onTap: () {
          _navigateToProductDetails(itemName); // Navigate to product details
        },
      ),
    );
  }

  void _removeFromWishlist(String itemName) {
    setState(() {
      _wishlistItems.remove(itemName);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName removed from wishlist'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            _undoRemove(itemName);
          },
        ),
      ),
    );
  }

  void _undoRemove(String itemName) {
    setState(() {
      _wishlistItems.add(itemName);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName added back to wishlist'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToProductDetails(String itemName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsPage(itemName: itemName)),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final String itemName;

  ProductDetailsPage({required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Product Name: $itemName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Wishlist'),
            ),
          ],
        ),
      ),
    );
  }
}
